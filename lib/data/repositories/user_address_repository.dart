import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/user_data_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/datasource/network/services/user_address_service.dart';
import 'package:onlinebozor/domain/mappers/user_mapper.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

@LazySingleton()
class UserAddressRepository {
  UserAddressRepository(this._userAddressService, this._userDataStorage);

  final UserAddressService _userAddressService;
  final UserDataStorage _userDataStorage;

  Future<List<UserAddress>> getActualUserAddresses() async {
    final response = await _userAddressService.getUserAddresses();
    final addresses = UserAddressRootResponse.fromJson(response.data).data;
    await _userDataStorage
        .setAddresses(addresses.map((e) => e.toHiveAddress()).toList());
    return addresses.map((e) => e.toAddress()).toList();
  }

  Future<List<UserAddress>> getSavedUserAddresses() async {
    return _userDataStorage.userAddresses.map((e) => e.toAddress()).toList();
  }

  Future<List<UserAddress>> getUserAddresses() async {
    final saved = await getSavedUserAddresses();
    if (saved.isNotEmpty) {
      return saved;
    } else {
      return await getActualUserAddresses();
    }
  }

  Future<void> addUserAddress({
    required String name,
    required int regionId,
    required int districtId,
    required int neighborhoodId,
    required String homeNum,
    required String apartmentNum,
    required String streetName,
    required bool isMain,
    required String? geo,
  }) async {
    await _userAddressService.addUserAddress(
      name: name,
      regionId: regionId,
      districtId: districtId,
      neighborhoodId: neighborhoodId,
      homeNum: homeNum,
      apartmentNum: apartmentNum,
      streetNum: streetName,
      isMain: isMain,
      geo: geo,
    );
    return;
  }

  Future<void> deleteAddress({required int id}) async {
    await _userAddressService.deleteUserAddress(userAddressId: id);
    return;
  }

  Future<void> updateMainAddress({
    required int id,
    required bool isMain,
  }) async {
    await _userAddressService.updateMainAddress(
        userAddressId: id, isMain: true);
    return;
  }

  Future<void> updateUserAddress({
    required String name,
    required int regionId,
    required int districtId,
    required int neighborhoodId,
    required String homeNum,
    required String apartmentNum,
    required String streetName,
    required bool isMain,
    required String? geo,
    required int id,
    required String state,
  }) async {
    await _userAddressService.updateUserAddress(
      name: name,
      regionId: regionId,
      districtId: districtId,
      neighborhoodId: neighborhoodId,
      homeNum: homeNum,
      apartmentNum: apartmentNum,
      streetNum: streetName,
      isMain: isMain,
      geo: geo,
      id: id,
      state: state,
    );
    return;
  }
}
