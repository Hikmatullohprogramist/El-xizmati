import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/auth_api.dart';
import 'package:onlinebozor/data/model/auth/one_id/one_id_response.dart';
import 'package:onlinebozor/data/storage/language_storage.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';

import '../../domain/repository/auth_repository.dart';
import '../model/auth/auth_start/auth_start_response.dart';
import '../model/auth/confirm/confirm_response.dart';
import '../model/auth/register_password/register_password_response.dart';


@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _api;
  final TokenStorage tokenStorage;
  final LanguageStorage languageStorage;
  String sessionToken = "";

  AuthRepositoryImpl(this._api, this.tokenStorage, this.languageStorage);

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
    final response = await _api.registerOrResetPassword(
        password: password, repeatPassword: repeatPassword);
    final confirmResponse =
        RegisterPasswordRootResponse.fromJson(response.data);
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
    }
    return;
  }

  @override
  Future<void> loginWithOneId(String accessCode) async {
    final response = await _api.loginWithOneId(accessCode: accessCode);
    final oneIdResponse = OneIdRootResponse.fromJson(response.data).data;
    if (oneIdResponse?.access_token != null) {
      await tokenStorage.isLogin.set(true);
      await tokenStorage.token.set(oneIdResponse?.access_token ?? "");
    }
    return;
  }

  @override
  Future<void> logOut() async {
    await tokenStorage.isLogin.clear();
    await tokenStorage.token.clear();
    await languageStorage.isLanguageSelection.clear();
    return;
  }
}
