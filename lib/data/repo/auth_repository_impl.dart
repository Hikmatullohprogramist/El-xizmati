import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/auth_api.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';
import 'package:onlinebozor/domain/model/auth/register_password/register_password_response.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';

import '../../domain/model/auth/auth_start/auth_start_response.dart';
import '../../domain/model/auth/confirm/confirm_response.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _api;
  final TokenStorage tokenStorage;
  String sessionToken = "";

  AuthRepositoryImpl(this._api, this.tokenStorage);

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
    verificationResponse.token ??
        tokenStorage.token.set(verificationResponse.token ?? "");
  }

  @override
  Future<void> confirm(String phone, String code) async {
    final response = await _api.confirm(
        phone: phone, code: code, sessionToken: sessionToken);
    final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
    confirmResponse.token ??
        tokenStorage.token.set(confirmResponse.token ?? "");
  }

  @override
  Future<void> forgetPassword(String phone) async {
    final response = await _api.forgetPassword(phone: phone);
    final forgetResponse = AuthStartResponse.fromJson(response.data);
    sessionToken = forgetResponse.data.session_token!;
  }

  @override
  Future<void> registerOrResetPassword(
      String password, String repeatPassword) async {
    final response = await _api.registerOrResetPassword(
        password: password, repeatPassword: repeatPassword);
    final confirmResponse =
        RegisterPasswordRootResponse.fromJson(response.data);
  }

  @override
  Future<void> recoveryConfirm(String phone, String code) async {
    final response = await _api.recoveryConfirm(
        phone: phone, code: code, sessionToken: sessionToken);
    final confirmResponse = ConfirmRootResponse.fromJson(response.data).data;
    confirmResponse.token ??
        tokenStorage.token.set(confirmResponse.token ?? "");
  }
}
