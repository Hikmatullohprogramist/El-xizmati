import 'dart:async';

import 'package:El_xizmati/data/datasource/network/sp_response/auth/auth_otp_confirm_response.dart';
import 'package:El_xizmati/data/datasource/network/sp_response/auth/auth_send_sms_response.dart';
import 'package:dio/src/response.dart';
import 'package:El_xizmati/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/entities/user_entity.dart';
import 'package:El_xizmati/data/datasource/network/responses/auth/auth_start/auth_start_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/auth/check/phone_check_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/auth/login/login_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/auth/one_id/one_id_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/face_id/validate_bio_doc_request.dart';
import 'package:El_xizmati/data/datasource/network/responses/register/register_otp_confirm_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/auth_service.dart';
import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/datasource/preference/user_preferences.dart';
import 'package:El_xizmati/data/mappers/user_mappers.dart';
import 'package:El_xizmati/data/repositories/favorite_repository.dart';

class AuthRepository {
  final AdEntityDao _adEntityDao;
  final AuthPreferences _authPreferences;
  final AuthService _authService;
  final FavoriteRepository _favoriteRepository;
  final UserAddressEntityDao _userAddressEntityDao;
  final UserEntityDao _userEntityDao;
  final UserPreferences _userPreferences;

  AuthRepository(
    this._adEntityDao,
    this._authPreferences,
    this._authService,
    this._favoriteRepository,
    this._userAddressEntityDao,
    this._userEntityDao,
    this._userPreferences,
  );

  String sessionToken = "";

  Future<AuthStartResponse> phoneVerification(String phone) async {
    final response = await _authService.phoneVerification(phone: phone);
    final authStartResponse = AuthStartResponse.fromJson(response.data);
    if (authStartResponse.data.is_registered == false) {
      sessionToken = authStartResponse.data.session_token!;
    }
    return authStartResponse;
  }

  Future<AuthSendSMSResponse> authSmSCode(String phone) async {
    final response = await _authService.phoneSendSms(phone: phone);
    final authSMSCode = AuthSendSMSResponse.fromJson(response.data);
    return authSMSCode;
  }

  Future<void> login(String phone, String password) async {
    final response = await _authService.login(phone: phone, password: password);
    final loginResponse = LoginRootResponse.fromJson(response.data).data;
    if (loginResponse.token != null) {
      await _authPreferences.setToken(loginResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);

      final actual = loginResponse.user;
      final saved = await _userEntityDao.getUser();

      await _userPreferences.setUserInfo(actual);

      if (actual != null) {
        await _userEntityDao.insertUser(
          UserEntity(
            id: actual.id ?? saved!.id,
            fullName: actual.fullName ?? saved?.fullName ?? "",
            pinfl: actual.pinfl ?? saved?.pinfl,
            tin: actual.tin ?? saved?.tin,
            gender: actual.gender ?? saved?.gender,
            docSeries: actual.docSeries ?? saved?.docSeries,
            docNumber: actual.docNumber ?? saved?.docNumber,
            regionId: actual.regionId ?? saved?.regionId,
            regionName: saved?.regionName ?? "",
            districtId: saved?.districtId,
            districtName: saved?.districtName ?? "",
            neighborhoodId: actual.neighborhoodId ?? saved?.neighborhoodId,
            neighborhoodName: saved?.neighborhoodName ?? "",
            houseNumber: actual.homeName ?? saved?.houseNumber,
            apartmentName: saved?.apartmentName,
            birthDate: actual.birthDate ?? saved?.birthDate ?? "",
            photo: actual.photo ?? saved?.photo ?? "",
            email: actual.email ?? saved?.email ?? "",
            phone: actual.mobilePhone ?? saved?.phone ?? "",
            notificationSource:
                actual.messageType ?? saved?.notificationSource ?? "",
            isIdentified: actual.isRegistered ?? saved?.isIdentified ?? false,
            state: saved?.state,
          ),
        );
      }

      await _favoriteRepository.pushAllFavoriteAds();
    }
    return;
  }

  Future<void> requestResetOtpCode(String phone) async {
    final response = await _authService.requestResetOtpCode(phone: phone);
    final forgetResponse = AuthStartResponse.fromJson(response.data);
    sessionToken = forgetResponse.data.session_token!;
    return;
  }

  Future<void> confirmResetOtpCode(String phone, String code) async {
    final response = await _authService.confirmResetOtpCode(
      phone: phone,
      code: code,
      sessionToken: sessionToken,
    );
    final confirmResponse = LoginRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await _authPreferences.setToken(confirmResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(confirmResponse.user);
      return;
    }
    return;
  }

  Future<void> setNewPassword(
    String password,
    String confirm,
  ) async {
    await _authService.setNewPassword(password: password, confirm: confirm);
    return;
  }

  Future<String> registerRequestOtpCode({
    required String docSeries,
    required String docNumber,
    required String birthDate,
    required String phoneNumber,
    required String password,
    required String confirm,
  }) async {
    final response = await _authService.registerRequestOtpCode(
      docSeries: docSeries,
      docNumber: docNumber,
      birthDate: birthDate,
      phoneNumber: phoneNumber,
      password: password,
      confirm: confirm,
    );
    final checkResponse = PhoneCheckResponse.fromJson(response.data);
    return checkResponse.data.sessionToken;
  }

  /// sp use
  Future<AuthOtpConfirmResponse?> registerConfirmOtpCode(String phone, String otpCode) async {
    final response = await _authService.sendConfirmOtpCode(otpCode: otpCode, phoneNumber: phone);
    final confirmResponse = AuthOtpConfirmRootResponse.fromJson(response.data).data;
    if (confirmResponse?.tokens != null) {
      await _authPreferences.setToken(confirmResponse?.tokens?.access ?? "");
      await _authPreferences.setRefreshToken(confirmResponse?.tokens?.refresh ?? "");
      await _authPreferences.setIsAuthorized(true);
    }
    return confirmResponse;
  }

  Future<void> registerFaceIdIdentity(String image, String secretKey) async {
    final rootResponse = await _authService.registerFaceIdIdentity(
      image: image,
      secretKey: secretKey,
    );
    final response = LoginRootResponse.fromJson(rootResponse.data).data;
    if (response.token != null) {
      await _authPreferences.setToken(response.token ?? "");
      await _authPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(response.user);
      await _favoriteRepository.pushAllFavoriteAds();
    }
  }

  Future<Response> validateByBioDoc(ValidateBioDocRequest request) async {
    final response = await _authService.validateByBioDoc(request: request);
    return response;
  }

  Future<Response> validateByPinfl(String pinfl) async {
    final response = await _authService.validateByPinfl(pinfl: pinfl);
    return response;
  }

  Future<void> signInFaceIdIdentity(String image, String secretKey) async {
    final rootResponse = await _authService.signInFaceIdIdentity(
      image: image,
      secretKey: secretKey,
    );
    final response = LoginRootResponse.fromJson(rootResponse.data).data;
    if (response.token != null) {
      await _authPreferences.setToken(response.token ?? "");
      await _authPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(response.user);
      await _favoriteRepository.pushAllFavoriteAds();
    }
  }

  Future<void> loginWithOneId(String accessCode) async {
    final root = await _authService.oneIdValidate(accessCode: accessCode);
    final oneIdResponse = OneIdRootResponse.fromJson(root.data).data;
    if (oneIdResponse.access_token != null) {
      final response = await _authService.oneIdLogin(
        accessCode: oneIdResponse.access_token ?? "",
      );
      final confirmResponse = LoginRootResponse.fromJson(response.data).data;
      final userResponse = confirmResponse.user;
      if (confirmResponse.token != null) {
        await _authPreferences.setToken(confirmResponse.token ?? "");
        await _authPreferences.setIsAuthorized(true);
        await _userPreferences.setUserInfo(confirmResponse.user);

        if (userResponse != null) {
          await _userEntityDao.insertUser(userResponse.toUserEntity());
        }
        return;
      }
      return;
    }
  }

  Future<void> logOut() async {
    await _adEntityDao.clear();
    await _authPreferences.clear();
    await _userAddressEntityDao.clear();
    await _userEntityDao.clear();
    await _userPreferences.clear();
    return;
  }
}
