import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
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
    getActualUserAddresses();
  }

  void reloadAddresses() {
    getActualUserAddresses(isReload: true);
  }

  void getActualUserAddresses({bool isReload = false}) {
    userAddressRepository
        .getUserAddresses(isReload: isReload)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                loadingState:
                    data.isEmpty ? LoadingState.empty : LoadingState.success,
                addresses: data,
              ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                loadingState: LoadingState.error,
              ));

          if (error.isRequiredShowError) {
            stateMessageManager.showErrorBottomSheet(error.localizedMessage);
          }
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> makeMainAddress(UserAddress address, int index) async {
    userAddressRepository
        .updateMainAddress(id: address.id)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          var addresses = states.addresses.toList(growable: true);
          var oldMain = addresses.firstIf((element) => element.isMain);
          if (oldMain != null) {
            var oldMainIndex = addresses.indexOf(oldMain);
            oldMain.isMain = false;
            var oldMainChanged = oldMain;
            addresses.remove(oldMain);
            addresses.insert(oldMainIndex, oldMainChanged);
          }

          var item = addresses[index];
          addresses.removeAt(index);
          item.isMain = true;
          addresses.insert(0, item);

          updateState((state) => state.copyWith(addresses: addresses));
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
          final addresses = states.addresses.toList(growable: true);
          addresses.removeIf((e) => e.id == address.id);
          updateState((state) => state.copyWith(addresses: addresses));
        })
        .onError((error) {
          logger.e(error);
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }
}
