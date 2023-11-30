import 'package:onlinebozor/data/model/profile/biometric_info/biometric_info_response.dart';
import 'package:onlinebozor/data/model/profile/user/user_info_response.dart';
import 'package:onlinebozor/data/model/profile/user_full/user_full_info_response.dart';

import '../../data/model/region /region_response.dart';

abstract class UserRepository {
  Future<UserFullInfoResponse> getFullUserInfo();

  Future<BiometricInfoResponse> getBiometricInfo(
      {required String phoneNumber,
      required String biometricSerial,
      required String biometricNumber,
      required String brithDate});

  Future<UserInfoResponse> getUserInfo(
      {required String phoneNumber, required String secretKey});

  Future<List<RegionResponse>> getRegions();

  Future<List<RegionResponse>> getDistricts(int regionId);

  Future<List<RegionResponse>> getStreets(int streetId);

  Future<void> sendUserInformation({
    required String email,
    required String gender,
    required String homeName,
    required int mahallaId,
    required String mobilePhone,
    required String photo,
    required int pinfl,
    required String postName,
    required String phoneNumber,
  });
}
