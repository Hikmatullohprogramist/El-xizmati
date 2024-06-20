import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'user_addresses_cubit.freezed.dart';
part 'user_addresses_state.dart';

@Injectable()
class UserAddressesCubit
    extends BaseCubit<UserAddressesState, UserAddressesEvent> {
  final UserAddressRepository userAddressRepository;

  UserAddressesCubit(this.userAddressRepository) : super(UserAddressesState()) {
    getController();
  }

  void reloadAddresses(){
    getController(isReload: true);
  }

  Future<void> getController({bool isReload = false}) async {
    try {
      if (states.controller == null) {
        final controller = getAddressController();
        updateState((state) => state.copyWith(controller: controller));
      } else if (isReload) {
        states.controller?.refresh();
      }
    } catch (e, stackTrace) {
      logger.w(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.localizedMessage);
    }
  }

  PagingController<int, UserAddress> getAddressController() {
    final controller = PagingController<int, UserAddress>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    logger.w(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        userAddressRepository
            .getActualUserAddresses(page: pageKey, limit: 20)
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length <= 1000) {
                controller.appendLastPage(data);
                logger.i(states.controller);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              controller.error = error;
              if (error.isRequiredShowError) {
                stateMessageManager
                    .showErrorBottomSheet(error.localizedMessage);
              }
            })
            .onFinished(() {})
            .executeFuture();
      },
    );
    return controller;
  }

  Future<void> makeMainAddress(UserAddress address, int index) async {
    userAddressRepository
        .updateMainAddress(id: address.id)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
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
        })
        .onError((error) {
          logger.e(error);
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> deleteUserAddress(UserAddress address) async {
    userAddressRepository
        .deleteAddress(id: address.id)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) async {
          states.controller?.itemList?.remove(address);
          states.controller?.notifyListeners();
          // await getController(false);
        })
        .onError((error) {
          logger.e(error);
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }
}
