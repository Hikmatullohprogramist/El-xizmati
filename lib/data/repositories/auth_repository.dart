import 'dart:async';
import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/entities/user_entity.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/auth_start/auth_start_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/confirm/confirm_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/eds/eds_sign_in_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/one_id/one_id_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/e_imzo_response/e_imzo_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/face_id/validate_bio_doc_request.dart';
import 'package:onlinebozor/data/datasource/network/services/auth_service.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';

// @LazySingleton()
class AuthRepository {
  final AdEntityDao _adEntityDao;
  final AuthService _authService;
  final CategoryEntityDao _categoryEntityDao;
  final LanguagePreferences _languagePreferences;
  final TokenPreferences _tokenPreferences;
  final UserPreferences _userPreferences;
  final UserEntityDao _userEntityDao;

  AuthRepository(
    this._adEntityDao,
    this._authService,
    this._categoryEntityDao,
    this._languagePreferences,
    this._tokenPreferences,
    this._userEntityDao,
    this._userPreferences,
  );

  String sessionToken = "";

  Future<AuthStartResponse> authStart(String phone) async {
    final response = await _authService.authStart(phone: phone);
    final authStartResponse = AuthStartResponse.fromJson(response.data);
    if (authStartResponse.data.is_registered == false) {
      sessionToken = authStartResponse.data.session_token!;
    }
    return authStartResponse;
  }

  Future<void> login(String phone, String password) async {
    final response = await _authService.login(phone: phone, password: password);
    final loginResponse = ConfirmRootResponse.fromJson(response.data).data;
    if (loginResponse.token != null) {
      await _tokenPreferences.setToken(loginResponse.token ?? "");
      await _tokenPreferences.setIsAuthorized(true);

      final actual = loginResponse.user;
      final saved = await _userEntityDao.getUser();

      await _userPreferences.setUserInfo(actual);

      if (actual != null) {
        await _userEntityDao.updateUser(
          UserEntity(
            id: actual.id ?? saved!.id,
            fullName: actual.fullName ?? saved?.fullName ?? "",
            pinfl: actual.pinfl ?? saved?.pinfl,
            tin: actual.tin ?? saved?.tin,
            gender: actual.gender ?? saved?.gender,
            docSerial: actual.passportSerial ?? saved?.docSerial,
            docNumber: actual.passportNumber ?? saved?.docNumber,
            regionId: actual.regionId ?? saved?.regionId,
            regionName: saved?.regionName ?? "",
            districtId: saved?.districtId,
            districtName: saved?.districtName ?? "",
            neighborhoodId: actual.neighborhoodId ?? saved?.neighborhoodId,
            neighborhoodName: saved?.neighborhoodName ?? "",
            houseNumber: actual.homeName ?? saved?.houseNumber,
            apartmentName: saved?.apartmentName,
            birthDate: actual.birthDate ?? saved?.birthDate,
            photo: actual.photo ?? saved?.photo,
            email: actual.email ?? saved?.email,
            phone: actual.mobilePhone ?? saved?.phone ?? "",
            notificationSource: actual.messageType ?? saved?.notificationSource,
            isIdentified: actual.isRegistered ?? saved?.isIdentified ?? false,
            state: saved?.state,
          ),
        );
      }
      // await favoriteRepository.pushAllFavoriteAds();
    }
    return;
  }

  Future<EImzoModel?> edsAuth() async {
    EImzoModel? eImzoModel;
    final response = await _authService.edsAuth();

    final int statusCode = response.statusCode;
    final resultClass = json.decode(utf8.decode(response.bodyBytes));
    if (statusCode == 200) {
      eImzoModel = EImzoModel.fromJson(resultClass);
    }
    return eImzoModel;
  }

  Future<int?> edsCheckStatus(String documentId, Timer? _timer) async {
    final response = await _authService.edsCheckStatus(documentId, _timer);

    final int statusCode = response.statusCode;
    final resultClass = json.decode(utf8.decode(response.bodyBytes));
    if (statusCode == 200) {
      if (resultClass["status"] == 1) {
        _timer?.cancel();
      }
      return resultClass["status"];
    }
    return resultClass["status"];
  }

  Future<void> edsSignIn(String sign) async {
    final response = await _authService.edsSignIn(sign: sign);
    final edsResponse = EdsSignInRootResponse.fromJson(response.data);
    final actual = edsResponse.user;
    if (edsResponse.token != null) {
      await _tokenPreferences.setToken(edsResponse.token ?? "");
      await _tokenPreferences.setIsAuthorized(true);
      final saved = await _userEntityDao.getUser();

      await _userPreferences.setUserTin(actual?.tin);
      await _userPreferences.setUserPinfl(actual?.pinfl);
      await _userPreferences.setIdentityState(actual?.isRegistered);

      if (actual != null) {
        await _userEntityDao.updateUser(
          UserEntity(
            id: actual.id,
            fullName: actual.fullName ?? saved?.fullName ?? "",
            pinfl: actual.pinfl ?? saved?.pinfl,
            tin: actual.tin ?? saved?.tin,
            gender: actual.gender ?? saved?.gender,
            docSerial: actual.passportSerial ?? saved?.docSerial,
            docNumber: actual.passportNumber ?? saved?.docNumber,
            regionId: actual.oblId ?? saved?.regionId,
            regionName: saved?.regionName ?? "",
            districtId: actual.areaId ?? saved?.districtId,
            districtName: saved?.districtName ?? "",
            neighborhoodId: actual.districtId ?? saved?.neighborhoodId,
            neighborhoodName: saved?.neighborhoodName ?? "",
            houseNumber: actual.homeName ?? saved?.houseNumber,
            apartmentName: saved?.apartmentName,
            birthDate: actual.birthDate ?? saved?.birthDate ?? "",
            photo: actual.photo ?? saved?.photo ?? "",
            email: actual.email ?? saved?.email ?? "",
            phone: actual.mobilePhone ?? saved?.phone ?? "",
            notificationSource: saved?.notificationSource ?? "",
            isIdentified: actual.isRegistered ?? saved?.isIdentified ?? false,
            state: saved?.state,
          ),
        );
      }
    }
    return;
  }

  Future<void> confirm(String phone, String code) async {
    final response = await _authService.confirm(
      phone: phone,
      code: code,
      sessionToken: sessionToken,
    );
    final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await _tokenPreferences.setToken(confirmResponse.token ?? "");
      await _tokenPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(confirmResponse.user);
      return;
    }
  }

  Future<void> forgetPassword(String phone) async {
    final response = await _authService.forgetPassword(phone: phone);
    final forgetResponse = AuthStartResponse.fromJson(response.data);
    sessionToken = forgetResponse.data.session_token!;
    return;
  }

  Future<void> registerOrResetPassword(
      String password, String repeatPassword) async {
    await _authService.registerOrResetPassword(
        password: password, repeatPassword: repeatPassword);
    return;
  }

  Future<Response> validateByBioDoc(ValidateBioDocRequest request) async {
    final response = await _authService.validateByBioDoc(request: request);
    return response;
  }

  Future<Response> validateByPinfl(String pinfl) async {
    final response = await _authService.validateByPinfl(pinfl: pinfl);
    return response;
  }

  Future<void> sendImage(String image, String secretKey) async {
    final rootResponse = await _authService.sendImage(
      image: image,
      secretKey: secretKey,
    );
    final response = ConfirmRootResponse.fromJson(rootResponse.data).data;
    if (response.token != null) {
      await _tokenPreferences.setToken(response.token ?? "");
      await _tokenPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(response.user);
      // await favoriteRepository.pushAllFavoriteAds();
    }
  }

  Future<void> recoveryConfirm(String phone, String code) async {
    final response = await _authService.recoveryConfirm(
      phone: phone,
      code: code,
      sessionToken: sessionToken,
    );
    final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await _tokenPreferences.setToken(confirmResponse.token ?? "");
      await _tokenPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(confirmResponse.user);
      return;
    }
    return;
  }

  Future<void> loginWithOneId(String accessCode) async {
    final root = await _authService.loginValidate(accessCode: accessCode);
    final oneIdResponse = OneIdRootResponse.fromJson(root.data).data;
    if (oneIdResponse.access_token != null) {
      final response = await _authService.loginWithOneId(
        accessCode: oneIdResponse.access_token ?? "",
      );
      final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
      if (confirmResponse.token != null) {
        await _tokenPreferences.setToken(confirmResponse.token ?? "");
        await _tokenPreferences.setIsAuthorized(true);
        await _userPreferences.setUserInfo(confirmResponse.user);
        return;
      }
      return;
    }
  }

  Future<void> logOut() async {
    await _adEntityDao.clear();
    await _categoryEntityDao.clear();
    await _languagePreferences.clear();
    await _languagePreferences.clear();
    await _tokenPreferences.clear();
    await _userEntityDao.clear();
    await _userPreferences.clear();
    return;
  }
}
