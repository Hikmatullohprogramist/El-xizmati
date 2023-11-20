import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/user_api.dart';
import 'package:onlinebozor/data/model/region%20/region_response.dart';
import 'package:onlinebozor/data/model/user/user_information_response.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImp extends UserRepository {
  final UserApi _api;

  UserRepositoryImp(this._api);

  @override
  Future<UserInformationResponse> getUserInformation() async {
    final response = await _api.getUserInformation();
    final result = UserInformationRootResponse.fromJson(response.data).data;
    return result;
  }

  @override
  Future<List<RegionResponse>> getRegions() async {
    final response = await _api.getRegions();
    final result = RegionRootResponse.fromJson(response.data).data;
    return result;
  }

  @override
  Future<List<RegionResponse>> getDistricts(int regionId) async {
    final response = await _api.getDistricts(regionId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result;
  }

  @override
  Future<List<RegionResponse>> getStreets(int streetId) async {
    final response = await _api.getStreets(streetId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result;
  }

  @override
  Future<UserInformationResponse> userIdentified(
      {required String phoneNumber,
      required String biometricSerial,
      required String biometricNumber,
      required String brithDate}) async {
    final response = await _api.identified(
        phoneNumber: phoneNumber,
        biometricSerial: biometricSerial,
        biometricNumber: biometricNumber,
        brithDate: brithDate);
    final result = UserInformationRootResponse.fromJson(response.data).data;
    return result;
  }
}