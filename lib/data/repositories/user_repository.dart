import 'package:injectable/injectable.dart';

import '../../data/hive_objects/user/user_info_object.dart';
import '../../data/responses/device/active_device_response.dart';
import '../../data/responses/profile/biometric_info/biometric_info_response.dart';
import '../../data/responses/profile/user/user_info_response.dart';
import '../../data/responses/profile/user_full/user_full_info_response.dart';
import '../../data/responses/region/region_response.dart';
import '../../data/services/user_service.dart';
import '../../data/storages/user_storage.dart';

@LazySingleton()
class UserRepository {
  final UserService _userService;
  final UserInfoStorage userInfoStorage;

  UserRepository(
    this._userService,
    this.userInfoStorage,
  );

  Future<UserFullInfoResponse> getFullUserInfo() async {
    final response = await _userService.getFullUserInfo();
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

  Future<BiometricInfoResponse> getBiometricInfo(
      {required String phoneNumber,
      required String biometricSerial,
      required String biometricNumber,
      required String brithDate}) async {
    final response = await _userService.getBiometricInfo(
        phoneNumber: phoneNumber,
        biometricSerial: biometricSerial,
        biometricNumber: biometricNumber,
        brithDate: brithDate);
    final result = BiometricInfoRootResponse.fromJson(response.data).data;
    return result;
  }

  Future<UserInfoResponse> getUserInfo(
      {required String phoneNumber, required String secretKey}) async {
    final response = await _userService.getUserInfo(
        secretKey: secretKey, phoneNumber: phoneNumber);
    final responseResult = UserInfoRootResponse.fromJson(response.data).data;
    return responseResult;
  }

  Future<List<RegionResponse>> getRegions() async {
    final response = await _userService.getRegions();
    final result = RegionRootResponse.fromJson(response.data).data;
    return result;
  }

  Future<List<RegionResponse>> getDistricts(int regionId) async {
    final response = await _userService.getDistricts(regionId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result;
  }

  Future<List<RegionResponse>> getStreets(int streetId) async {
    final response = await _userService.getStreets(streetId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result;
  }

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
  }) async {
    final userInfo = userInfoStorage.userInformation.call();

    await _userService.sendUserInformation(
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

  Future<bool> isFullRegister() async {
    final isRegister =
        userInfoStorage.userInformation.call()?.isRegistered ?? false;
    return isRegister;
  }

  Future<List<ActiveDeviceResponse>> getActiveDevice() async {
    final deviceResponse = await _userService.getActiveDevices();
    final response =
        ActiveDeviceRootResponse.fromJson(deviceResponse.data).data;
    return response;
  }

  Future<void> removeActiveResponse(ActiveDeviceResponse response) async {
    await _userService.removeActiveDevice(response);
    return;
  }
}
