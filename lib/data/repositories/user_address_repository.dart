import 'package:onlinebozor/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/datasource/network/services/user_address_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/domain/mappers/user_mapper.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

class UserAddressRepository {
  final AuthPreferences _authPreferences;
  final UserAddressEntityDao _userAddressEntityDao;
  final UserAddressService _userAddressService;
  final UserPreferences _userPreferences;

  UserAddressRepository(
    this._authPreferences,
    this._userAddressEntityDao,
    this._userAddressService,
    this._userPreferences,
  );

  Future<List<UserAddress>> getActualUserAddresses() async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final response = await _userAddressService.getUserAddresses();
    final addresses = UserAddressRootResponse.fromJson(response.data).data;
    await _userAddressEntityDao.upsertAll(
      addresses.map((e) => e.toAddressEntity()).toList(),
    );
    return addresses.map((e) => e.toAddress()).toList();
  }

  Future<List<UserAddress>> getSavedUserAddresses() async {
    final entities = await _userAddressEntityDao.readSavedAddresses();
    return entities.map((e) => e.toAddress()).toList();
  }

  Future<List<UserAddress>> getUserAddresses({bool isReload = false}) async {
    final count = await _userAddressEntityDao.readAddressesCount() ?? 0;
    if (isReload || count <= 0) {
      return getActualUserAddresses();
    } else {
      return getSavedUserAddresses();
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
    await _userAddressEntityDao.deleteAddressById(id);
    return;
  }

  Future<void> updateMainAddress({
    required int id,
    required bool isMain,
  }) async {
    await _userAddressService.updateMainAddress(
      userAddressId: id,
      isMain: true,
    );
    await _userAddressEntityDao.readMainAddress();
    return;
  }

  Future<void> updateUserAddress({
    required String name,
    required int regionId,
    required int districtId,
    required int neighborhoodId,
    required String houseNumber,
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
      homeNum: houseNumber,
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
