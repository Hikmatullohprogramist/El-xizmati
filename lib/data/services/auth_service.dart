import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../storages/token_storage.dart';

@lazySingleton
class AuthService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  AuthService(this._dio, this.tokenStorage);

  Future<Response> authStart({required String phone}) {
    final body = {RestQueryKeys.queryPhoneNumber: phone};
    return _dio.post('v1/auth/phone/verification', data: body);
  }

  Future<Response> confirm({
    required String phone,
    required String code,
    required String sessionToken,
  }) {
    final body = {
      RestQueryKeys.queryPhoneNumber: phone,
      RestQueryKeys.querySessionToken: sessionToken,
      RestQueryKeys.querySecurityCode: code
    };
    return _dio.post('v1/auth/phone/verification/register', data: body);
  }

  Future<Response> verification({
    required String phone,
    required String password,
  }) {
    final body = {
      RestQueryKeys.queryUserName: phone,
      RestQueryKeys.queryPassword: password
    };
    return _dio.post('v2/auth/login', data: body);
  }

  Future<Response> forgetPassword({required String phone}) {
    final body = {RestQueryKeys.queryPhoneNumber: phone};
    return _dio.post('v1/auth/phone/verification/recovery', data: body);
  }

  Future<Response> recoveryConfirm(
      {required String phone,
      required String code,
      required String sessionToken}) {
    final body = {
      RestQueryKeys.queryPhoneNumber: phone,
      RestQueryKeys.querySessionToken: sessionToken,
      RestQueryKeys.querySecurityCode: code
    };
    return _dio.post('v1/auth/phone/verification/recovery/password',
        data: body);
  }

  Future<Response> registerOrResetPassword({
    required String password,
    required String repeatPassword,
  }) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final body = {
      RestQueryKeys.queryPassword: password,
      RestQueryKeys.queryRepeatPassword: repeatPassword
    };
    return _dio.put('v1/auth/user/change_password',
        data: body, options: Options(headers: headers));
  }

  Future<Response> loginValidate({required String accessCode}) {
    final body = {RestQueryKeys.queryAccessToken: accessCode};
    return _dio.post("v1/auth/one_id/login-validate", data: body);
  }

  Future<Response> loginWithOneId({required String accessCode}) {
    final body = {RestQueryKeys.queryAccessToken: accessCode};
    return _dio.post("v1/auth/one_id/login", data: body);
  }
}
