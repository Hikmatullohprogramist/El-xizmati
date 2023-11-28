import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';

@lazySingleton
class AuthApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  AuthApi(this._dio, this.tokenStorage);

  Future<Response> authStart({required String phone}) {
    final body = {'phone_number': phone};
    return _dio.post('v1/auth/phone/verification', data: body);
  }

  Future<Response> confirm(
      {required String phone,
      required String code,
      required String sessionToken}) {
    final body = {
      'phone_number': phone,
      'session_token': sessionToken,
      "security_code": code
    };
    return _dio.post('v1/auth/phone/verification/register', data: body);
  }

  Future<Response> verification(
      {required String phone, required String password}) {
    final body = {"username": phone, "password": password};
    return _dio.post('v2/auth/login', data: body);
  }

  Future<Response> forgetPassword({required String phone}) {
    final body = {"phone_number": phone};
    return _dio.post('v1/auth/phone/verification/recovery', data: body);
  }

  Future<Response> recoveryConfirm(
      {required String phone,
      required String code,
      required String sessionToken}) {
    final body = {
      "phone_number": phone,
      "session_token": sessionToken,
      "security_code": code
    };
    return _dio.post('v1/auth/phone/verification/recovery/password',
        data: body);
  }

  Future<Response> registerOrResetPassword(
      {required String password, required String repeatPassword}) async {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final body = {"password": password, "repeat_password": repeatPassword};
    return _dio.put('v1/auth/user/change_password',
        data: body, options: Options(headers: headers));
  }

  Future<Response> loginValidate({required String accessCode}) {
    final body = {"accessToken": accessCode};
    return _dio.post("v1/auth/one_id/login-validate", data: body);
  }

  Future<Response> loginWithOneId({required String accessCode}) {
    final body = {"accessToken": accessCode};
    return _dio.post("v1/auth/one_id/login", data: body);
  }
}
