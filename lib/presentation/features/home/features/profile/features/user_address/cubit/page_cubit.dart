import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.userAddressRepository) : super(PageState()) {
    getController(false);
  }

  final UserAddressRepository userAddressRepository;

  Future<void> getController(bool isReload) async {
    try {
      if (isReload && states.controller != null) {
        states.controller?.refresh();
      } else {
        final controller = states.controller ?? getAddressController(status: 1);
        updateState((state) => state.copyWith(controller: controller));
      }
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      snackBarManager.error(e.toString());
    }
  }

  PagingController<int, UserAddress> getAddressController({
    required int status,
  }) {
    final addressController = PagingController<int, UserAddress>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    logger.i(states.controller);

    try {
      addressController.addPageRequestListener(
        (pageKey) async {
          final items = await userAddressRepository.getUserAddresses();
          if (items.length <= 1000) {
            addressController.appendLastPage(items);
            logger.i(states.controller);
            return;
          }
          addressController.appendPage(items, pageKey + 1);
          logger.i(states.controller);
        },
      );
    } catch (exception) {
      logger.e(exception.toString());
      snackBarManager.error("server xatolik yuz beradi");
    }

    return addressController;
  }

  Future<void> makeMainAddress(UserAddress address, int index) async {
    try {
      await userAddressRepository.updateMainAddress(
        id: address.id,
        isMain: true,
      );

      var items = states.controller?.itemList;
      if (items != null) {
        var oldMain = items.firstIf((element) => element.isMain);
        if (oldMain != null) {
          var oldMainIndex = items.indexOf(oldMain);
          oldMain.isMain = false;
          var oldMainChanged = oldMain;
          items.remove(oldMain);
          items.insert(oldMainIndex, oldMainChanged);
        }

        var item = items[index];
        items.removeAt(index);
        item.isMain = true;
        items.insert(0, item);

        states.controller?.notifyListeners();
      }
    } catch (e) {
      snackBarManager.error(e.toString());
      logger.e(e.toString());
    }
  }

  Future<void> deleteUserAddress(UserAddress address) async {
    try {
      await userAddressRepository.deleteAddress(id: address.id);
      states.controller?.itemList?.remove(address);
      states.controller?.notifyListeners();
      await getController(false);
    } catch (e) {
      snackBarManager.error(e.toString());
      logger.e(e.toString());
    }
  }
}
