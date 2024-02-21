import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../common/enum/enums.dart';
import '../../../../../../../data/repositories/user_address_repository.dart';
import '../../../../../../../data/responses/address/user_address_response.dart';

part 'user_addresses_cubit.freezed.dart';

part 'user_addresses_state.dart';

@Injectable()
class UserAddressesCubit
    extends BaseCubit<UserAddressesBuildable, UserAddressesListenable> {
  UserAddressesCubit(this.userAddressRepository)
      : super(UserAddressesBuildable()) {
    getController();
  }

  final UserAddressRepository userAddressRepository;

  Future<void> getController() async {
    try {
      final controller =
          buildable.addressPagingController ?? getAddressController(status: 1);
      build((buildable) =>
          buildable.copyWith(addressPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.addressPagingController);
    }
  }

  PagingController<int, UserAddressResponse> getAddressController({
    required int status,
  }) {
    final addressController = PagingController<int, UserAddressResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.addressPagingController);

    try {
      addressController.addPageRequestListener(
        (pageKey) async {
          final addressList = await userAddressRepository.getUserAddresses();
          if (addressList.length <= 1000) {
            addressController.appendLastPage(addressList);
            log.i(buildable.addressPagingController);
            return;
          }
          addressController.appendPage(addressList, pageKey + 1);
          log.i(buildable.addressPagingController);
        },
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      display.error("server xatolik yuz beradi");
    }

    return addressController;
  }

  Future<void> editUserAddress(UserAddressResponse address) async {
    await invoke(UserAddressesListenable(UserAddressesEffect.editUserAddress,
        address: address));
  }

  Future<void> updateMainAddress(UserAddressResponse address) async {
    try {
      await userAddressRepository.updateMainAddress(
        id: address.id,
        isMain: address.is_main ?? false,
      );
    } catch (e) {
      display.error(e.toString());
      log.e(e.toString());
    }
  }

  Future<void> deleteUserAddress(UserAddressResponse address) async {
    try {
      await userAddressRepository.deleteAddress(id: address.id);
      buildable.addressPagingController?.itemList?.remove(address);
      buildable.addressPagingController?.notifyListeners();
      await getController();
    } catch (e) {
      display.error(e.toString());
      log.e(e.toString());
    }
  }
}
