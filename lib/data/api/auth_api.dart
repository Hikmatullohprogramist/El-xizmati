import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

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
    return _dio.post('v1/auth/phone/verification/recovery/password', data: body);
  }

  Future<Response> registerOrResetPassword(
      {required String password, required String repeatPassword}) {
    final body = {"password": password, "repeat_password": repeatPassword};
    return _dio.post('v1/auth/user/change_password', data: body);
  }
}
