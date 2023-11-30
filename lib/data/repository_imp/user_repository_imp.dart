import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/user_api.dart';
import 'package:onlinebozor/data/hive_object/user/user_info_object.dart';
import 'package:onlinebozor/data/model/profile/biometric_info/biometric_info_response.dart';
import 'package:onlinebozor/data/model/profile/user/user_info_response.dart';
import 'package:onlinebozor/data/model/profile/user_full/user_full_info_response.dart';
import 'package:onlinebozor/data/model/region%20/region_response.dart';
import 'package:onlinebozor/data/storage/user_storage.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImp extends UserRepository {
  final UserApi _api;
  final UserInfoStorage userInfoStorage;

  UserRepositoryImp(this._api, this.userInfoStorage);

  @override
  Future<UserFullInfoResponse> getFullUserInfo() async {
    final response = await _api.getFullUserInfo();
    final result = UserFullInfoRootResponse.fromJson(response.data).data;
    final userInfo = userInfoStorage.userInformation.call();
    userInfoStorage.update(UserInfoObject(
        gender: result.gender ?? userInfo?.gender,
        postName: result.post_name ?? userInfo?.gender,
        tin: result.tin ?? userInfo?.tin,
        pinfl: result.pinfl ?? userInfo?.pinfl,
        isRegistered: result.is_registered ?? userInfo?.isRegistered,
        state: userInfo?.state,
        registeredWithEimzo: userInfo?.registeredWithEimzo,
        photo: result.photo ?? userInfo?.photo,
        passportSerial: result.passport_serial ?? userInfo?.passportSerial,
        passportNumber: result.passport_number ?? userInfo?.passportNumber,
        oblId: result.mahalla_id ?? userInfo?.oblId,
        mobilePhone: result.mobile_phone ?? userInfo?.mobilePhone,
        isPassword: userInfo?.isPassword,
        homeName: result.home_name ?? userInfo?.homeName,
        eimzoAllowToLogin: userInfo?.eimzoAllowToLogin,
        birthDate: result.birth_date ?? userInfo?.birthDate,
        username: result.username ?? userInfo?.username,
        areaId: userInfo?.areaId,
        apartmentName: userInfo?.apartmentName,
        id: result.id ?? userInfo?.id,
        email: result.email ?? userInfo?.email,
        fullName: result.full_name ?? userInfo?.fullName,
        districtId: result.district_id ?? userInfo?.districtId,
        regionId: result.region_id ?? userInfo?.regionId,
        districtName: userInfo?.districtName,
        regionName: userInfo?.regionName,
        areaName: userInfo?.areaName,
        oblName: userInfo?.oblName));
    return result;
  }

  @override
  Future<BiometricInfoResponse> getBiometricInfo(
      {required String phoneNumber,
      required String biometricSerial,
      required String biometricNumber,
      required String brithDate}) async {
    final response = await _api.getBiometricInfo(
        phoneNumber: phoneNumber,
        biometricSerial: biometricSerial,
        biometricNumber: biometricNumber,
        brithDate: brithDate);
    final result = BiometricInfoRootResponse.fromJson(response.data).data;
    return result;
  }

  @override
  Future<UserInfoResponse> getUserInfo(
      {required String phoneNumber, required String secretKey}) async {
    final response =
        await _api.getUserInfo(secretKey: secretKey, phoneNumber: phoneNumber);
    final responseResult = UserInfoRootResponse.fromJson(response.data).data;
    return responseResult;
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
  Future<void> sendUserInformation(
      { required String email,
        required String gender,
        required String homeName,
        required int mahallaId,
        required String mobilePhone,
        required String photo,
        required int pinfl,
        required String postName,
        required String phoneNumber,}) async {
    final userInfo = userInfoStorage.userInformation.call();

    await _api.sendUserInformation(
        email: email,
        gender: gender,
        homeName: homeName,
        id: userInfo?.id ?? -1,
        mahallaId: mahallaId,
        mobilePhone: mobilePhone,
        photo: photo,
        pinfl: pinfl,
        postName: postName,
        phoneNumber: phoneNumber);
  }

  @override
  Future<bool> isFullRegister() async {
    final isRegister =
        userInfoStorage.userInformation.call()?.isRegistered ?? false;
    return isRegister;
  }
}