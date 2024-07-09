import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/entities/user_entity.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/datasource/network/responses/active_sessions/active_session_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/profile/user/user_info_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/profile/user_full/user_full_info_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/profile/verify_identity/identity_document_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/region/region_and_district_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/region/region_root_response.dart';
import 'package:onlinebozor/data/datasource/network/services/private/user_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/domain/mappers/region_mapper.dart';
import 'package:onlinebozor/domain/mappers/user_mapper.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/region/region_and_district.dart';
import 'package:onlinebozor/domain/models/social_account/social_account_info.dart';
import 'package:onlinebozor/domain/models/street/street.dart';

class UserRepository {
  final AuthPreferences _authPreferences;
  final UserService _userService;
  final UserPreferences _userPreferences;
  final UserEntityDao _userEntityDao;

  UserRepository(
    this._authPreferences,
    this._userService,
    this._userPreferences,
    this._userEntityDao,
  );

  Future<UserEntity?> getSavedUser() {
    return _userEntityDao.getUser();
  }

  Future<UserResponse> getUser() async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();

    final response = await _userService.getUserProfile();
    final actual = UserRootResponse.fromJson(response.data).data;
    final saved = await _userEntityDao.getUser();

    await _userPreferences.setUserTin(actual.tin);
    await _userPreferences.setUserPinfl(actual.pinfl);
    await _userPreferences.setIdentityState(actual.is_registered);

    await _userEntityDao.updateUser(
      UserEntity(
        id: actual.id ?? saved!.id,
        fullName: actual.full_name ?? saved?.fullName ?? "",
        pinfl: actual.pinfl ?? saved?.pinfl,
        tin: actual.tin ?? saved?.tin,
        gender: actual.gender ?? saved?.gender,
        docSeries: actual.passport_serial ?? saved?.docSeries,
        docNumber: actual.passport_number ?? saved?.docNumber,
        regionId: actual.region_id ?? saved?.regionId,
        regionName: saved?.regionName ?? "",
        districtId: saved?.districtId,
        districtName: saved?.districtName ?? "",
        neighborhoodId: actual.mahalla_id ?? saved?.neighborhoodId,
        neighborhoodName: saved?.neighborhoodName ?? "",
        houseNumber: actual.home_name ?? saved?.houseNumber,
        apartmentName: saved?.apartmentName,
        birthDate: actual.birth_date ?? saved?.birthDate ?? "",
        photo: actual.photo ?? saved?.photo ?? "",
        email: actual.email ?? saved?.email ?? "",
        phone: actual.mobile_phone ?? saved?.phone ?? "",
        notificationSource:
            actual.message_type ?? saved?.notificationSource ?? "",
        isIdentified: actual.is_registered ?? saved?.isIdentified ?? false,
        state: saved?.state,
      ),
    );
    return actual;
  }

  Future<IdentityDocumentInfoResponse> getIdentityDocument({
    required String phoneNumber,
    required String docSeries,
    required String docNumber,
    required String brithDate,
  }) async {
    final response = await _userService.getIdentityDocument(
      phoneNumber: phoneNumber,
      biometricSerial: docSeries,
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
    return result.toRegionAndDistrict();
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
    final response = await _userService.getNeighborhoods(streetId);
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
    required String docSeries,
    required String docNumber,
    required String birthDate,
    required String postName,
    required String phoneNumber,
  }) async {
    final user = await _userEntityDao.getUser();
    await _userService.updateUserProfile(
      id: user!.id,
      email: email,
      gender: gender,
      homeName: homeName,
      neighborhoodId: neighborhoodId,
      mobilePhone: mobilePhone,
      photo: photo,
      pinfl: pinfl,
      docSeries: docSeries,
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
    required String docSeries,
    required String docNumber,
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
        neighborhoodId: mahallaId,
        mobilePhone: mobilePhone,
        docSeries: docSeries,
        docNumber: docNumber,
        phoneNumber: phoneNumber,
        photo: photo,
        pinfl: pinfl,
        postName: postName,
        regionId: region_Id);
  }

  Future<void> updateNotificationSources({required String sources}) async {
    await _userService.updateNotificationSources(sources: sources);
  }

  Future<void> updateSocialAccountInfo({
    required List<SocialAccountInfo?> socials,
  }) async {
    await _userService.updateSocialAccountInfo(socials: socials);
  }

  bool isIdentityVerified() {
    return _userPreferences.isIdentified;
  }

  bool isNotIdentified() {
    return !_userPreferences.isIdentified;
  }

  Future<List<ActiveSession>> getActiveSessions() async {
    final response = await _userService.getActiveSessions();
    final root = ActiveSessionsRootResponse.fromJson(response.data).data;
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

  Future<void> removeActiveSession(ActiveSession session) async {
    await _userService.removeActiveSession(session);
    return;
  }
}
