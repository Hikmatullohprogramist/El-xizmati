import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';
import 'package:onlinebozor/domain/repository/user_address_response.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../common/enum/enums.dart';

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
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
    }
  }

  PagingController<int, UserAddressResponse> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, UserAddressResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await userAddressRepository.getUserAddresses();
        if (adsList.length <= 1000) {
          adController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.adsPagingController);
      },
    );
    return adController;
  }

  Future<void> editUserAddress(UserAddressResponse address) async {
   await invoke(UserAddressesListenable(UserAddressesEffect.editUserAddress,
        address: address));
  }

  Future<void> updateMainAddress(UserAddressResponse address) async {
    try {
      await userAddressRepository.updateMainAddress(
          id: address.id ?? -1, isMain: address.is_main ?? false);
    } catch (e) {
      display.error(e.toString());
      log.e(e.toString());
    }
  }

  Future<void> deleteUserAddress(UserAddressResponse address) async {
    try {
      await userAddressRepository.deleteAddress(id: address.id ?? -1);
      buildable.adsPagingController?.itemList?.remove(address);
      buildable.adsPagingController?.notifyListeners();
      await getController();
    } catch (e) {
      display.error(e.toString());
      log.e(e.toString());
    }
  }
}
