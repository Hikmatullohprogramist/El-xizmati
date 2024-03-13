import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../../domain/models/face_id/by_passport.dart';
import '../storages/token_storage.dart';

@lazySingleton
class AuthService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  AuthService(this._dio, this.tokenStorage);

  Future<Response> authStart({required String phone}) {
    final body = {RestQueryKeys.phoneNumber: phone};
    return _dio.post('api/mobile/v1/auth/phone/verification', data: body);
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
    return _dio.post('api/mobile/v1/auth/phone/verification/register', data: body);
  }

  Future<Response> byPassport({required ByPassportModel byPassportModel}){
    final body = {
      RestQueryKeys.brithDate: byPassportModel.birthDate,
      RestQueryKeys.passportNumber: byPassportModel.passportNumber,
      RestQueryKeys.passportSerial: byPassportModel.passportSerial,
    };
    return _dio.post('api/v1/auth/face_id/by_passport', data: body);
  }
  Future<Response> byPassportPinfl({required String pinfl}){
    final body = {
      RestQueryKeys.pinfl:pinfl,
    };
    return _dio.post('api/v1/auth/face_id/by_pinfl', data: body);
  }

  Future<Response> sendImage({required String image, required String secretKey}){
    final body = {
      RestQueryKeys.imageData: image,
      RestQueryKeys.secretKey: secretKey,
    };
    return _dio.post('api/v1/auth/face_id/by_image', data: body);
  }

  Future<Response> verification({
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
    return _dio.post('api/mobile/v1/auth/phone/verification/recovery', data: body);
  }

  Future<Response> recoveryConfirm(
      {required String phone,
      required String code,
      required String sessionToken}) {
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
