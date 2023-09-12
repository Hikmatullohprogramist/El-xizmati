import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<Response> login(String phone, [String? hash]) {
    final body = {'phone': phone, 'hash': hash};
    return _dio.post('user/login', data: body);
  }

  Future<Response> verify(String phone, String code) {
    final body = {'phone': phone, 'code': code};
    return _dio.post('/user/login/verify', data: body);
  }
}
