import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/datasource/network/services/user_address_service.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/mappers/user_mapper.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

// @LazySingleton()
class UserAddressRepository {
  final TokenPreferences _tokenPreferences;
  final UserAddressEntityDao _userAddressEntityDao;
  final UserAddressService _userAddressService;
  final UserPreferences _userPreferences;

  UserAddressRepository(
    this._tokenPreferences,
    this._userAddressEntityDao,
    this._userAddressService,
    this._userPreferences,
  );

  Future<List<UserAddress>> getActualUserAddresses() async {
    if (_tokenPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final response = await _userAddressService.getUserAddresses();
    final addresses = UserAddressRootResponse.fromJson(response.data).data;
    await _userAddressEntityDao.upsertAll(
      addresses.map((e) => e.toAddressEntity()).toList(),
    );
    throw UnsupportedError("return commented code");
    // return addresses.map((e) => e.toAddress()).toList();
  }

  Future<List<UserAddress>> getSavedUserAddresses() async {
    final entities = await _userAddressEntityDao.getSavedAddresses();
    throw UnsupportedError("return commented code");
    // return entities.map((e) => e.toAddress()).toList();
  }

  Future<List<UserAddress>> getUserAddresses() async {
    Logger().w("getUserAddresses called");
    final count = await _userAddressEntityDao.getAddressesCount() ?? 0;
    try {
      if (count > 0) {
        Logger().w("getUserAddresses hasSavedAddresses = true");
        return getSavedUserAddresses();
      } else {
        Logger().w("getUserAddresses hasSavedAddresses = false");
        return getActualUserAddresses();
      }
    } catch (e, stackTrace) {
      Logger().w(e, stackTrace: stackTrace);
      rethrow;
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
