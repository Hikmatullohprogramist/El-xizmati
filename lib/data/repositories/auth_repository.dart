import 'dart:async';
import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/entities/user_entity.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/auth_start/auth_start_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/eds/eds_sign_in_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/login/login_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/one_id/one_id_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/e_imzo_response/e_imzo_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/face_id/validate_bio_doc_request.dart';
import 'package:onlinebozor/data/datasource/network/services/private/auth_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/mappers/user_mapper.dart';

class AuthRepository {
  final AdEntityDao _adEntityDao;
  final AuthPreferences _authPreferences;
  final AuthService _authService;
  final UserAddressEntityDao _userAddressEntityDao;
  final UserEntityDao _userEntityDao;
  final UserPreferences _userPreferences;

  AuthRepository(
    this._adEntityDao,
    this._authPreferences,
    this._authService,
    this._userAddressEntityDao,
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
    final userResponse = edsResponse.user;
    if (edsResponse.token != null) {
      await _authPreferences.setToken(edsResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);

      await _userPreferences.setUserTin(userResponse?.tin);
      await _userPreferences.setUserPinfl(userResponse?.pinfl);
      await _userPreferences.setIdentityState(userResponse?.isRegistered);

      if (userResponse != null) {
        await _userEntityDao.insertUser(userResponse.toUserEntity());
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
    final confirmResponse = LoginRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await _authPreferences.setToken(confirmResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);
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
    final response = LoginRootResponse.fromJson(rootResponse.data).data;
    if (response.token != null) {
      await _authPreferences.setToken(response.token ?? "");
      await _authPreferences.setIsAuthorized(true);
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
    final confirmResponse = LoginRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await _authPreferences.setToken(confirmResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);
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
