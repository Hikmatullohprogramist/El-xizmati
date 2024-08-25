import 'package:El_xizmati/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/entities/user_entity.dart';
import 'package:El_xizmati/data/datasource/network/constants/constants.dart';
import 'package:El_xizmati/data/datasource/network/responses/active_sessions/active_session_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/profile/user/user_info_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/profile/user_full/user_full_info_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/profile/verify_identity/identity_document_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_service.dart';
import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/datasource/preference/user_preferences.dart';
import 'package:El_xizmati/data/error/app_locale_exception.dart';
import 'package:El_xizmati/domain/mappers/user_mapper.dart';
import 'package:El_xizmati/domain/models/active_sessions/active_session.dart';
import 'package:El_xizmati/domain/models/social_account/social_account_info.dart';

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
