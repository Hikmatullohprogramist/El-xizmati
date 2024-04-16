import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/active_sessions/active_session_response.dart';
import 'package:onlinebozor/data/responses/region/region_and_district_response.dart';
import 'package:onlinebozor/domain/mappers/active_session_mapper.dart';
import 'package:onlinebozor/domain/mappers/region_mapper.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/region/region_and_district.dart';

import '../../common/constants.dart';
import '../../data/hive_objects/user/user_info_object.dart';
import '../../data/responses/profile/user/user_info_response.dart';
import '../../data/responses/profile/user_full/user_full_info_response.dart';
import '../../data/responses/region/region_root_response.dart';
import '../../data/services/user_service.dart';
import '../../data/storages/user_storage.dart';
import '../../domain/models/social_account/social_account_info.dart';
import '../../domain/models/street/street.dart';
import '../responses/profile/verify_identity/identity_document_response.dart';

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
        // registeredWithEimzo: userInfo?.registeredWithEimzo,
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

  Future<IdentityDocumentInfoResponse> getIdentityDocument({
    required String phoneNumber,
    required String docSerial,
    required String docNumber,
    required String brithDate,
  }) async {
    final response = await _userService.getIdentityDocument(
      phoneNumber: phoneNumber,
      biometricSerial: docSerial,
      biometricNumber: docNumber,
      brithDate: brithDate,
    );
    final result = IdentityDocumentRootResponse.fromJson(response.data).data;
    return result;
  }

  Future<UserInfoResponse> continueVerifyingIdentity({
    required String phoneNumber,
    required String secretKey,
  }) async {
    final response = await _userService.continueVerifyingIdentity(
      secretKey: secretKey,
      phoneNumber: phoneNumber,
    );
    final responseResult = UserInfoRootResponse.fromJson(response.data).data;
    return responseResult;
  }

  Future<RegionAndDistrict> getRegionAndDistricts() async {
    final response = await _userService.getRegionAndDistricts();
    final result = RegionAndDistrictRootResponse.fromJson(response.data).data;
    return result.toMap();
  }

  Future<List<Region>> getRegions() async {
    final response = await _userService.getRegions();
    final result = RegionRootResponse.fromJson(response.data).data;
    return result.map((e) => e.toRegion()).toList();
  }

  Future<List<District>> getDistricts(int regionId) async {
    final response = await _userService.getDistricts(regionId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result.map((e) => e.toDistrict(regionId)).toList();
  }

  Future<List<Neighborhood>> getNeighborhoods(int streetId) async {
    final response = await _userService.getStreets(streetId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result.map((e) => e.toNeighborhood()).toList();
  }

  Future<void> updateUserProfile({
    required String email,
    required String gender,
    required String homeName,
    required int neighborhoodId,
    required String mobilePhone,
    required String photo,
    required int pinfl,
    required String docSerial,
    required String docNumber,
    required String birthDate,
    required String postName,
    required String phoneNumber,
  }) async {
    final userInfo = userInfoStorage.userInformation.call();
    await _userService.sendUserInformation(
      email: email,
      gender: gender,
      homeName: homeName,
      id: userInfo?.id ?? -1,
      neighborhoodId: neighborhoodId,
      mobilePhone: mobilePhone,
      photo: photo,
      pinfl: pinfl,
      docSerial: docSerial,
      docNumber: docNumber,
      birthDate: birthDate,
      postName: postName,
      phoneNumber: phoneNumber,
    );
  }

  Future<void> validateUser({
    required String birthDate,
    required int districtId,
    required String email,
    required String fullName,
    required String gender,
    required String homeName,
    required int id,
    required int mahallaId,
    required String mobilePhone,
    required String passportNumber,
    required String passportSeries,
    required String phoneNumber,
    required String photo,
    required int pinfl,
    required String postName,
    required int region_Id,
  }) async {
    await _userService.validateUser(
        birthDate: birthDate,
        districtId: districtId,
        email: email,
        fullName: fullName,
        gender: gender,
        homeName: homeName,
        id: id,
        mahallaId: mahallaId,
        mobilePhone: mobilePhone,
        passportNumber: passportNumber,
        passportSeries: passportSeries,
        phoneNumber: phoneNumber,
        photo: photo,
        pinfl: pinfl,
        postName: postName,
        region_Id: region_Id);
  }

  Future<void> updateNotificationSources({required String sources}) async {
    await _userService.updateNotificationSources(sources: sources);
  }

  Future<void> updateSocialAccountInfo({
    required List<SocialAccountInfo?> socials,
  }) async {
    await _userService.updateSocialAccountInfo(socials: socials);
  }

  Future<bool> isFullRegister() async {
    return userInfoStorage.userInformation.call()?.isRegistered ?? false;
  }

  Future<List<ActiveSession>> getActiveDevice() async {
    final deviceResponse = await _userService.getActiveDevices();
    final root = ActiveSessionsRootResponse.fromJson(deviceResponse.data).data;
    final userAgent = DeviceInfo.userAgent;
    final items = root.map((e) => e.toMap(e.user_agent == userAgent)).toList();
    items.sort((a, b) {
      if (a.isCurrentSession == b.isCurrentSession) {
        return b.lastActivityAt?.compareTo(a.lastActivityAt ?? '') ?? -1;
      }
      return a.isCurrentSession ? -1 : 1;
    });
    return items;
  }

  Future<void> removeActiveResponse(ActiveSession session) async {
    await _userService.removeActiveDevice(session);
    return;
  }
}
