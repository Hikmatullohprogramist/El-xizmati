import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<Response> authStart(String phone) {
    final body = {'phone_number': phone};
    return _dio.post('v1/auth/phone/verification', data: body);
  }

  Future<Response> login(String phone, String password) {
    final body = {"username": phone, "password": password};
    return _dio.post('v1/auth/login', data: body);
  }

  Future<Response> register(String phone, String code, String session_token) {
    final body = {
      "phone_number": phone,
      "session_token": session_token,
      "security_code": code
    };
    return _dio.post('v1/auth/phone/verification/register', data: body);
  }

  Future<Response> setPassword(String password, String repeatPassword) {
    final body = {"password": password, "repeat_password": repeatPassword};
    return _dio.post('v1/auth/user/change_password', data: body);
  }

  // Future<Response> login(String phone, [String? hash]) {
  //   final body = {'phone': phone, 'hash': hash};
  //   return _dio.post('user/login', data: body);
  // }

  Future<Response> verify(String phone, String code) {
    final body = {'phone': phone, 'code': code};
    return _dio.post('/user/login/verify', data: body);
  }
}
