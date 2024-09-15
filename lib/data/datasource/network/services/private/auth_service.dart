import 'dart:async';

import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_query_keys.dart';
import 'package:El_xizmati/data/datasource/network/responses/face_id/validate_bio_doc_request.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  ///
  /// Phone check
  ///

  Future<Response> phoneVerification({required String phone}) {
    final body = {RestQueryKeys.phoneNumber: phone};
    return _dio.post('api/mobile/auth/send-sms/', data: body);
  }


  /// use sp
  Future<Response> phoneSendSms({required String phone}) {
    final body = {RestQueryKeys.phoneNumber: "+$phone"};
    return _dio.post('api/mobile/auth/send-sms/', data: body);
  }

  ///
  /// Register
  ///

  Future<Response> registerRequestOtpCode({
    required String docSeries,
    required String docNumber,
    required String birthDate,
    required String phoneNumber,
    required String password,
    required String confirm,
  }) async {
    final body = {
      RestQueryKeys.docSeries: docSeries,
      RestQueryKeys.docNumber: docNumber,
      RestQueryKeys.brithDate: birthDate,
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.password: password,
      RestQueryKeys.confirm: confirm
    };
    return _dio.post('api/mobile/v1/auth/set-user-info/', data: body);
  }

  Future<Response> sendConfirmOtpCode({
    required String phoneNumber,
    required String otpCode,
  }) {
    final body = {
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.code: otpCode
    };
    return _dio.post('/api/mobile/auth/verify-phone-number/', data: body);
  }

  Future<Response> registerFaceIdIdentity({
    required String image,
    required String secretKey,
  }) {
    final body = {
      RestQueryKeys.secretKey: secretKey,
      RestQueryKeys.imageData: image,
    };

    return _dio.post('api/mobile/v1/auth/identity-verify', data: body);
  }

  ///
  /// Face Id Login
  ///

  Future<Response> validateByBioDoc({required ValidateBioDocRequest request}) {
    final body = {
      RestQueryKeys.brithDate: request.birthDate,
      RestQueryKeys.passportSerial: request.docSeries,
      RestQueryKeys.passportNumber: request.docNumber,
    };
    return _dio.post('api/v1/auth/face_id/by_passport', data: body);
  }

  Future<Response> validateByPinfl({required String pinfl}) {
    final body = {RestQueryKeys.pinfl: pinfl};
    return _dio.post('api/v1/auth/face_id/by_pinfl', data: body);
  }

  Future<Response> signInFaceIdIdentity({
    required String image,
    required String secretKey,
  }) {
    final body = {
      RestQueryKeys.imageData: image,
      RestQueryKeys.secretKey: secretKey,
    };
    return _dio.post('api/v1/auth/face_id/by_image', data: body);
  }

  ///
  /// Login
  ///

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

  ///
  /// Reset Password
  ///

  Future<Response> requestResetOtpCode({required String phone}) {
    final body = {RestQueryKeys.phoneNumber: phone};
    return _dio.post('api/mobile/v1/auth/phone/verification/recovery',
        data: body);
  }

  Future<Response> confirmResetOtpCode({
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

  Future<Response> setNewPassword({
    required String password,
    required String confirm,
  }) async {
    final body = {
      RestQueryKeys.password: password,
      RestQueryKeys.repeatPassword: confirm
    };
    return _dio.put('api/mobile/v1/auth/user/change_password', data: body);
  }

  ///
  /// One Id login
  ///

  Future<Response> oneIdValidate({required String accessCode}) {
    final body = {RestQueryKeys.accessToken: accessCode};
    return _dio.post("api/mobile/v1/auth/one_id/login-validate", data: body);
  }

  Future<Response> oneIdLogin({required String accessCode}) {
    final body = {RestQueryKeys.accessToken: accessCode};
    return _dio.post("api/mobile/v1/auth/one_id/login", data: body);
  }
}
