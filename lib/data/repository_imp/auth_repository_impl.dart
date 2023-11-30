import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/auth_api.dart';
import 'package:onlinebozor/data/hive_object/user/user_info_object.dart';
import 'package:onlinebozor/data/model/auth/one_id/one_id_response.dart';
import 'package:onlinebozor/data/storage/language_storage.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';
import 'package:onlinebozor/data/storage/user_storage.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../../domain/repository/auth_repository.dart';
import '../model/auth/auth_start/auth_start_response.dart';
import '../model/auth/confirm/confirm_response.dart';


@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _api;
  final TokenStorage tokenStorage;
  final LanguageStorage languageStorage;
  final UserInfoStorage userInfoStorage;
  String sessionToken = "";
  final FavoriteRepository favoriteRepository;

  AuthRepositoryImpl(this._api, this.tokenStorage, this.languageStorage,
      this.favoriteRepository, this.userInfoStorage);

  @override
  Future<AuthStartResponse> authStart(String phone) async {
    final response = await _api.authStart(phone: phone);
    final authStartResponse = AuthStartResponse.fromJson(response.data);
    if (authStartResponse.data.is_registered == false) {
      sessionToken = authStartResponse.data.session_token!;
    }
    return authStartResponse;
  }

  @override
  Future<void> verification(String phone, String password) async {
    final response = await _api.verification(phone: phone, password: password);
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
      await favoriteRepository.pushAllFavoriteAds();
    }
    return;
  }

  @override
  Future<void> confirm(String phone, String code) async {
    final response = await _api.confirm(
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
      await favoriteRepository.pushAllFavoriteAds();
      return;
    }
  }

  @override
  Future<void> forgetPassword(String phone) async {
    final response = await _api.forgetPassword(phone: phone);
    final forgetResponse = AuthStartResponse.fromJson(response.data);
    sessionToken = forgetResponse.data.session_token!;
    return;
  }

  @override
  Future<void> registerOrResetPassword(
      String password, String repeatPassword) async {
    await _api.registerOrResetPassword(
        password: password, repeatPassword: repeatPassword);
    return;
  }

  @override
  Future<void> recoveryConfirm(String phone, String code) async {
    final response = await _api.recoveryConfirm(
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
      await favoriteRepository.pushAllFavoriteAds();
      return;
    }
    return;
  }

  @override
  Future<void> loginWithOneId(String accessCode) async {
    final responseValidate = await _api.loginValidate(accessCode: accessCode);
    final oneIdResponse =
        OneIdRootResponse.fromJson(responseValidate.data).data;
    if (oneIdResponse?.access_token != null) {
      final response = await _api.loginWithOneId(
          accessCode: oneIdResponse?.access_token ?? "");
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
        await favoriteRepository.pushAllFavoriteAds();
      }
      return;
    }
    return;
  }

  @override
  Future<void> logOut() async {
    await tokenStorage.isLogin.clear();
    await tokenStorage.token.clear();
    await userInfoStorage.userInformation.clear();
    await languageStorage.isLanguageSelection.clear();
    return;
  }
}
