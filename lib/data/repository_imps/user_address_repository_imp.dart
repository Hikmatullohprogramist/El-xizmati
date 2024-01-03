import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repositories/user_address_respository.dart';

import '../responses/address/user_address_response.dart';
import '../services/user_address_service.dart';

@LazySingleton(as: UserAddressRepository)
class UserAddressRepositoryImp extends UserAddressRepository {
  UserAddressRepositoryImp(this._userAddressService);

  final UserAddressService _userAddressService;

  @override
  Future<List<UserAddressResponse>> getUserAddresses() async {
    final response = await _userAddressService.getUserAddresses();
    final userAddresses = UserAddressRootResponse.fromJson(response.data).data;
    return userAddresses;
  }

  @override
  Future<void> addUserAddress({
    required String name,
    required int regionId,
    required int districtId,
    required int mahallaId,
    required String homeNum,
    required String apartmentNum,
    required String streetNum,
    required bool isMain,
    required String? geo,
  }) async {
    await _userAddressService.addUserAddress(
        name: name,
        regionId: regionId,
        districtId: districtId,
        mahallaId: mahallaId,
        homeNum: homeNum,
        apartmentNum: apartmentNum,
        streetNum: streetNum,
        isMain: isMain,
        geo: geo,
    );
    return;
  }

  @override
  Future<void> deleteAddress({required int id}) async {
    await _userAddressService.deleteUserAddress(userAddressId: id);
    return;
  }

  @override
  Future<void> updateMainAddress({required int id, required bool isMain}) async {
    await _userAddressService.updateMainAddress(userAddressId: id, isMain:true );
    return;
  }

  @override
  Future<void> updateUserAddress(
      {required String name,
      required int regionId,
      required int districtId,
      required int mahallaId,
      required String homeNum,
      required String apartmentNum,
      required String streetNum,
      required bool isMain,
      required String? geo,
      required int id,
      required String state}) async {
    await _userAddressService.updateUserAddress(
        name: name,
        regionId: regionId,
        districtId: districtId,
        mahallaId: mahallaId,
        homeNum: homeNum,
        apartmentNum: apartmentNum,
        streetNum: streetNum,
        isMain: isMain,
        geo: geo,
        id: id,
        state: state);
    return;
  }
}
