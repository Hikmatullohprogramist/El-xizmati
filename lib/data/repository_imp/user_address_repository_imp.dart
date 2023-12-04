import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/user_address_api.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';
import 'package:onlinebozor/domain/repository/user_address_response.dart';

@LazySingleton(as: UserAddressRepository)
class UserAddressRepositoryImp extends UserAddressRepository {
  UserAddressRepositoryImp(this._api);

  final UserAddressApi _api;

  @override
  Future<List<UserAddressResponse>> getUserAddresses() async {
    final response = await _api.getUserAddresses();
    final userAddresses = UserAddressRootResponse.fromJson(response.data).data;
    return userAddresses ?? List.empty();
  }

  @override
  Future<void> addUserAddress(
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
    await _api.addUserAddress(
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

  @override
  Future<void> deleteAddress({required int id}) async {
    await _api.deleteUserAddress(userAddressId: id);
    return;
  }

  @override
  Future<void> updateMainAddress({required int id}) async {
    await _api.updateMainAddress(userAddressId: id);
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
    await _api.updateUserAddress(
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
