import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/auth_api.dart';
import 'package:onlinebozor/data/storage/storage.dart';
import 'package:onlinebozor/domain/model/auth_start/auth_start_response.dart';
import 'package:onlinebozor/domain/model/confirm/confirm_response.dart';
import 'package:onlinebozor/domain/model/login%20/login_response.dart';
import 'package:onlinebozor/domain/model/register/register_response.dart';
import 'package:onlinebozor/domain/model/token/token.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _api;
  final Storage _storage;
  String sessionToken = "";

  AuthRepositoryImpl(this._api, this._storage);

  @override
  Future<AuthStartResponse> authStart(String phone) async {
    final response = await _api.authStart(phone);
    final authStartResponse = AuthStartResponse.fromJson(response.data);
    if (!authStartResponse.data.is_registered) {
      sessionToken = authStartResponse.data.session_token!;
    }
    return authStartResponse;
  }

  @override
  Future<LoginResponse> login(String phone, String password) async {
    final response = await _api.login(phone = phone, password = password);
    final loginResponse = LoginResponse.fromJson(response.data);
    return loginResponse;
  }

  @override
  Future<RegisterResponse> register(String phone, String code) async {
    final response = await _api.register(phone, code, sessionToken);
    final registerResponse = RegisterResponse.fromJson(response.data);
    return registerResponse;
  }

  @override
  Future<ConfirmResponse> setPassword(
      String password, String repeatPassword) async {
    final response = await _api.setPassword(password, repeatPassword);
    final confirmResponse = ConfirmResponse.fromJson(response.data);
    return confirmResponse;
  }

  // String base64Response(String value) {
  //   return base64.encode(utf8.encode(value));
  // }

  // @override
  // Future<void> login(String phone) {
  //   return _api.login(phone);
  // }

  @override
  Future<void> verify(String phone, String code) async {
    final response = await _api.verify(phone, code);
    final token = Token.fromJson(response.data);
    await _storage.token.set(token);
  }
}