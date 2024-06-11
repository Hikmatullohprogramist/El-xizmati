import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

import '../responses/face_id/validate_bio_doc_request.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Response> authStart({required String phone}) {
    final body = {RestQueryKeys.phoneNumber: phone};
    return _dio.post('api/mobile/v1/auth/phone/verification', data: body);
  }

  Future<http.Response> edsAuth() async {
    final response = await http.post(
      Uri.parse('https://hujjat.uz/mobile-id/frontend/mobile/auth'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> edsCheckStatus(String documentId, Timer? _timer) async {
    final response = await http.post(
      Uri.parse(
          'https://hujjat.uz/mobile-id/frontend/mobile/status?documentId=${documentId}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<Response> edsSignIn({
    required String sign,
  }) async {
    final body = {
      RestQueryKeys.accessToken: sign,
    };
    // return _dio.post('api/v2/mobile/auth/e-imzo/login', queryParameters: body);
    return _dio.get('auth/eimzo-v2/$sign');
  }

  Future<Response> confirm({
    required String phone,
    required String code,
    required String sessionToken,
  }) {
    final body = {
      RestQueryKeys.phoneNumber: phone,
      RestQueryKeys.sessionToken: sessionToken,
      RestQueryKeys.securityCode: code
    };
    return _dio.post('api/mobile/v1/auth/otp/confirm', data: body);
  }

  Future<Response> validateByBioDoc({required ValidateBioDocRequest request}) {
    final body = {
      RestQueryKeys.brithDate: request.birth_date,
      RestQueryKeys.passportNumber: request.passport_number,
      RestQueryKeys.passportSerial: request.passport_serial,
    };
    return _dio.post('api/v1/auth/face_id/by_passport', data: body);
  }

  Future<Response> validateByPinfl({required String pinfl}) {
    final body = {RestQueryKeys.pinfl: pinfl};
    return _dio.post('api/v1/auth/face_id/by_pinfl', data: body);
  }

  Future<Response> sendImage({
    required String image,
    required String secretKey,
  }) {
    final body = {
      RestQueryKeys.imageData: image,
      RestQueryKeys.secretKey: secretKey,
    };
    return _dio.post('api/v1/auth/face_id/by_image', data: body);
  }

  Future<Response> login({
    required String phone,
    required String password,
  }) {
    final body = {
      RestQueryKeys.queryUserName: phone,
      RestQueryKeys.password: password
    };
    return _dio.post('api/mobile/v2/auth/login', data: body);
  }

  Future<Response> forgetPassword({required String phone}) {
    final body = {RestQueryKeys.phoneNumber: phone};
    return _dio.post('api/mobile/v1/auth/phone/verification/recovery',
        data: body);
  }

  Future<Response> recoveryConfirm({
    required String phone,
    required String code,
    required String sessionToken,
  }) {
    final body = {
      RestQueryKeys.phoneNumber: phone,
      RestQueryKeys.sessionToken: sessionToken,
      RestQueryKeys.securityCode: code
    };
    return _dio.post('api/mobile/v1/auth/phone/verification/recovery/password',
        data: body);
  }

  Future<Response> registerOrResetPassword({
    required String password,
    required String repeatPassword,
  }) async {
    final body = {
      RestQueryKeys.password: password,
      RestQueryKeys.confirmPassword: repeatPassword
    };
    return _dio.put('api/mobile/v1/auth/user/change_password', data: body);
  }

  Future<Response> loginValidate({required String accessCode}) {
    final body = {RestQueryKeys.accessToken: accessCode};
    return _dio.post("api/mobile/v1/auth/one_id/login-validate", data: body);
  }

  Future<Response> loginWithOneId({required String accessCode}) {
    final body = {RestQueryKeys.accessToken: accessCode};
    return _dio.post("api/mobile/v1/auth/one_id/login", data: body);
  }
}
