import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../common/enum/enums.dart';
import '../../../../../../../data/repositories/user_address_repository.dart';
import '../../../../../../../data/responses/address/user_address_response.dart';

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
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  PagingController<int, UserAddressResponse> getAddressController({
    required int status,
  }) {
    final addressController = PagingController<int, UserAddressResponse>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    try {
      addressController.addPageRequestListener(
        (pageKey) async {
          final addressList = await userAddressRepository.getUserAddresses();
          if (addressList.length <= 1000) {
            addressController.appendLastPage(addressList);
            log.i(states.controller);
            return;
          }
          addressController.appendPage(addressList, pageKey + 1);
          log.i(states.controller);
        },
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      display.error("server xatolik yuz beradi");
    }

    return addressController;
  }

  Future<void> makeMainAddress(UserAddressResponse address, int index) async {
    try {
      await userAddressRepository.updateMainAddress(
        id: address.id,
        isMain: true,
      );

      var items = states.controller?.itemList;
      if (items != null) {
        var oldMain =
            items.firstWhereOrNull((element) => element.is_main == true);
        if (oldMain != null) {
          var oldMainIndex = items.indexOf(oldMain);
          var oldMainChanged = oldMain.copyWith(is_main: false);
          items.remove(oldMain);
          items.insert(oldMainIndex, oldMainChanged);
        }

        var item = items[index];
        items.removeAt(index);
        items.insert(0, item.copyWith(is_main: true));
        states.controller?.notifyListeners();
      }
    } catch (e) {
      display.error(e.toString());
      log.e(e.toString());
    }
  }

  Future<void> deleteUserAddress(UserAddressResponse address) async {
    try {
      await userAddressRepository.deleteAddress(id: address.id);
      states.controller?.itemList?.remove(address);
      states.controller?.notifyListeners();
      await getController(false);
    } catch (e) {
      display.error(e.toString());
      log.e(e.toString());
    }
  }
}
