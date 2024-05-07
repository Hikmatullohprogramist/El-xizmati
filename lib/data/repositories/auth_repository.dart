import 'dart:async';
import 'dart:convert';

import 'package:dio/src/response.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/hive_objects/user/user_hive_object.dart';
import 'package:onlinebozor/data/datasource/hive/storages/language_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/token_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/user_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/auth_start/auth_start_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/confirm/confirm_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/eds/eds_sign_in_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/one_id/one_id_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/e_imzo_response/e_imzo_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/face_id/validate_bio_doc_request.dart';
import 'package:onlinebozor/data/datasource/network/services/auth_service.dart';

@LazySingleton()
class AuthRepository {
  final AuthService _authService;
  final TokenStorage tokenStorage;
  final LanguageStorage languageStorage;
  final UserStorage userStorage;

  AuthRepository(
    this._authService,
    this.tokenStorage,
    this.languageStorage,
    this.userStorage,
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
      await tokenStorage.setToken(loginResponse.token ?? "");
      await tokenStorage.setLoginState(true);
      final user = loginResponse.user;
      await userStorage.set(
        UserHiveObject(
          districtId: user?.districtId,
          fullName: user?.fullName,
          email: user?.email,
          tin: user?.tin,
          id: user?.id,
          apartmentName: user?.apartmentName,
          areaId: user?.areaId,
          username: user?.username,
          birthDate: user?.birthDate,
          eimzoAllowToLogin: user?.eimzoAllowToLogin,
          gender: user?.gender,
          homeName: user?.homeName,
          isPassword: user?.isPassword,
          isIdentityVerified: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          // registeredWithEimzo: user?.registeredWithEimzo,
          state: user?.state,
        ),
      );
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
    final edsUserResponse = edsResponse.user;
    if (edsResponse.token != null) {
      await tokenStorage.setToken(edsResponse.token ?? "");
      await tokenStorage.setLoginState(true);
      final user = edsUserResponse;

      await userStorage.set(
        UserHiveObject(
          districtId: user?.districtId,
          fullName: user?.fullName,
          email: user?.email,
          tin: user?.tin,
          id: user?.id,
          apartmentName: user?.apartmentName,
          areaId: user?.areaId,
          username: user?.username,
          birthDate: user?.birthDate,
          eimzoAllowToLogin: user?.eimzoAllowToLogin,
          gender: user?.gender,
          homeName: user?.homeName,
          isPassword: user?.isPassword,
          isIdentityVerified: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          state: user?.state,
        ),
      );
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
      await tokenStorage.setToken(confirmResponse.token ?? "");
      await tokenStorage.setLoginState(true);
      final user = confirmResponse.user;
      await userStorage.set(
        UserHiveObject(
          districtId: user?.districtId,
          fullName: user?.fullName,
          email: user?.email,
          tin: user?.tin,
          id: user?.id,
          apartmentName: user?.apartmentName,
          areaId: user?.areaId,
          username: user?.username,
          birthDate: user?.birthDate,
          eimzoAllowToLogin: user?.eimzoAllowToLogin,
          gender: user?.gender,
          homeName: user?.homeName,
          isPassword: user?.isPassword,
          isIdentityVerified: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          // registeredWithEimzo: user?.registeredWithEimzo,
          state: user?.state,
        ),
      );
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
      await tokenStorage.setToken(response.token ?? "");
      await tokenStorage.setLoginState(true);
      final user = response.user;
      await userStorage.set(
        UserHiveObject(
          districtId: user?.districtId,
          fullName: user?.fullName,
          email: user?.email,
          tin: user?.tin,
          id: user?.id,
          apartmentName: user?.apartmentName,
          areaId: user?.areaId,
          username: user?.username,
          birthDate: user?.birthDate,
          eimzoAllowToLogin: user?.eimzoAllowToLogin,
          gender: user?.gender,
          homeName: user?.homeName,
          isPassword: user?.isPassword,
          isIdentityVerified: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          // registeredWithEimzo: user?.registeredWithEimzo,
          state: user?.state,
        ),
      );
      // await favoriteRepository.pushAllFavoriteAds();
    }
  }

  Future<void> recoveryConfirm(String phone, String code) async {
    final response = await _authService.recoveryConfirm(
        phone: phone, code: code, sessionToken: sessionToken);
    final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await tokenStorage.setToken(confirmResponse.token ?? "");
      await tokenStorage.setLoginState(true);
      final user = confirmResponse.user;
      await userStorage.set(UserHiveObject(
          districtId: user?.districtId,
          fullName: user?.fullName,
          email: user?.email,
          tin: user?.tin,
          id: user?.id,
          apartmentName: user?.apartmentName,
          areaId: user?.areaId,
          username: user?.username,
          birthDate: user?.birthDate,
          eimzoAllowToLogin: user?.eimzoAllowToLogin,
          gender: user?.gender,
          homeName: user?.homeName,
          isPassword: user?.isPassword,
          isIdentityVerified: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          // registeredWithEimzo: user?.registeredWithEimzo,
          state: user?.state));
      return;
    }
    return;
  }

  Future<void> loginWithOneId(String accessCode) async {
    final responseValidate =
        await _authService.loginValidate(accessCode: accessCode);
    final oneIdResponse =
        OneIdRootResponse.fromJson(responseValidate.data).data;
    if (oneIdResponse.access_token != null) {
      final response = await _authService.loginWithOneId(
          accessCode: oneIdResponse.access_token ?? "");
      final loginResponse = ConfirmRootResponse.fromJson(response.data).data;
      if (loginResponse.token != null) {
        await tokenStorage.setToken(loginResponse.token ?? "");
        await tokenStorage.setLoginState(true);
        final user = loginResponse.user;
        await userStorage.set(
          UserHiveObject(
            districtId: user?.districtId,
            fullName: user?.fullName,
            email: user?.email,
            tin: user?.tin,
            id: user?.id,
            apartmentName: user?.apartmentName,
            areaId: user?.areaId,
            username: user?.username,
            birthDate: user?.birthDate,
            eimzoAllowToLogin: user?.eimzoAllowToLogin,
            gender: user?.gender,
            homeName: user?.homeName,
            isPassword: user?.isPassword,
            isIdentityVerified: user?.isRegistered,
            mobilePhone: user?.mobilePhone,
            oblId: user?.oblId,
            passportNumber: user?.passportNumber,
            passportSerial: user?.passportSerial,
            photo: user?.photo,
            pinfl: user?.pinfl,
            postName: user?.username,
            // registeredWithEimzo: user?.registeredWithEimzo,
            state: user?.state,
          ),
        );
      }
      return;
    }
    return;
  }

  Future<void> logOut() async {
    await tokenStorage.clear();
    await userStorage.clear();
    await languageStorage.clear();
    return;
  }
}
