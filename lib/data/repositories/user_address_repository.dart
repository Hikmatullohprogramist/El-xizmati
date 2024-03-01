import 'package:injectable/injectable.dart';

import '../../data/responses/address/user_address_response.dart';
import '../../data/services/user_address_service.dart';

@LazySingleton()
class UserAddressRepository {
  UserAddressRepository(this.service);

  final UserAddressService service;

  Future<List<UserAddressResponse>> getUserAddresses() async {
    final response = await service.getUserAddresses();
    final userAddresses = UserAddressRootResponse.fromJson(response.data).data;
    return userAddresses;
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
    await service.addUserAddress(
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
    await service.deleteUserAddress(userAddressId: id);
    return;
  }

  Future<void> updateMainAddress({
    required int id,
    required bool isMain,
  }) async {
    await service.updateMainAddress(userAddressId: id, isMain: true);
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
    await service.updateUserAddress(
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
        state: state);
    return;
  }
}
