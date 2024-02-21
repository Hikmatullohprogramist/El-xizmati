import 'package:injectable/injectable.dart';

import '../../data/hive_objects/user/user_info_object.dart';
import '../../data/responses/auth/auth_start/auth_start_response.dart';
import '../../data/responses/auth/confirm/confirm_response.dart';
import '../../data/responses/auth/one_id/one_id_response.dart';
import '../../data/services/auth_service.dart';
import '../../data/storages/language_storage.dart';
import '../../data/storages/token_storage.dart';
import '../../data/storages/user_storage.dart';

@LazySingleton()
class AuthRepository {
  final AuthService _authService;
  final TokenStorage tokenStorage;
  final LanguageStorage languageStorage;
  final UserInfoStorage userInfoStorage;
  String sessionToken = "";

  AuthRepository(
    this._authService,
    this.tokenStorage,
    this.languageStorage,
    this.userInfoStorage,
  );

  Future<AuthStartResponse> authStart(String phone) async {
    final response = await _authService.authStart(phone: phone);
    final authStartResponse = AuthStartResponse.fromJson(response.data);
    if (authStartResponse.data.is_registered == false) {
      sessionToken = authStartResponse.data.session_token!;
    }
    return authStartResponse;
  }

  Future<void> verification(String phone, String password) async {
    final response =
        await _authService.verification(phone: phone, password: password);
    final verificationResponse =
        ConfirmRootResponse.fromJson(response.data).data;
    if (verificationResponse.token != null) {
      await tokenStorage.token.set(verificationResponse.token ?? "");
      await tokenStorage.isLogin.set(true);
      final user = verificationResponse.user;
      userInfoStorage.userInformation.set(UserInfoObject(
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
          isRegistered: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          registeredWithEimzo: user?.registeredWithEimzo,
          state: user?.state));
      // await favoriteRepository.pushAllFavoriteAds();
    }
    return;
  }

  Future<void> confirm(String phone, String code) async {
    final response = await _authService.confirm(
        phone: phone, code: code, sessionToken: sessionToken);
    final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await tokenStorage.token.set(confirmResponse.token ?? "");
      await tokenStorage.isLogin.set(true);
      final user = confirmResponse.user;
      userInfoStorage.userInformation.set(UserInfoObject(
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
          isRegistered: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          registeredWithEimzo: user?.registeredWithEimzo,
          state: user?.state));
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

  Future<void> recoveryConfirm(String phone, String code) async {
    final response = await _authService.recoveryConfirm(
        phone: phone, code: code, sessionToken: sessionToken);
    final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
    if (confirmResponse.token != null) {
      await tokenStorage.token.set(confirmResponse.token ?? "");
      await tokenStorage.isLogin.set(true);
      final user = confirmResponse.user;
      userInfoStorage.userInformation.set(UserInfoObject(
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
          isRegistered: user?.isRegistered,
          mobilePhone: user?.mobilePhone,
          oblId: user?.oblId,
          passportNumber: user?.passportNumber,
          passportSerial: user?.passportSerial,
          photo: user?.photo,
          pinfl: user?.pinfl,
          postName: user?.username,
          registeredWithEimzo: user?.registeredWithEimzo,
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
        await tokenStorage.token.set(loginResponse.token ?? "");
        await tokenStorage.isLogin.set(true);
        final user = loginResponse.user;
        userInfoStorage.userInformation.set(UserInfoObject(
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
            isRegistered: user?.isRegistered,
            mobilePhone: user?.mobilePhone,
            oblId: user?.oblId,
            passportNumber: user?.passportNumber,
            passportSerial: user?.passportSerial,
            photo: user?.photo,
            pinfl: user?.pinfl,
            postName: user?.username,
            registeredWithEimzo: user?.registeredWithEimzo,
            state: user?.state));
      }
      return;
    }
    return;
  }

  Future<void> logOut() async {
    await tokenStorage.isLogin.clear();
    await tokenStorage.token.clear();
    await userInfoStorage.userInformation.clear();
    await languageStorage.isLanguageSelection.clear();
    return;
  }
}
