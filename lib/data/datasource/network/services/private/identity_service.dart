import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

class IdentityService {
  final Dio _dio;

  IdentityService(this._dio);

  Future<Response> getIdentityDocument({
    required String phoneNumber,
    required String biometricSerial,
    required String biometricNumber,
    required String brithDate,
  }) {
    final body = {
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.passportSerial: biometricSerial,
      RestQueryKeys.passportNumber: biometricNumber,
      RestQueryKeys.brithDate: brithDate
    };
    return _dio.post('api/mobile/v1/user/profile', data: body);
  }

  Future<Response> continueVerifyingIdentity({
    required String secretKey,
    required String phoneNumber,
  }) {
    final data = {
      RestQueryKeys.secretKey: secretKey,
      RestQueryKeys.phoneNumber: phoneNumber
    };
    return _dio.post(
      'api/mobile/v1/user/profile/verify/in_progress',
      data: data,
    );
  }

  Future<Response> validateUser({
    required int id,
    required int pinfl,
    required String birthDate,
    required String email,
    required String fullName,
    required String gender,
    required String homeName,
    required String mobilePhone,
    required String docSeries,
    required String docNumber,
    required String phoneNumber,
    required String photo,
    required String postName,
    required int regionId,
    required int districtId,
    required int neighborhoodId,
  }) async {
    final params = {
      RestQueryKeys.brithDate: birthDate,
      RestQueryKeys.districtId: districtId,
      RestQueryKeys.email: email,
      RestQueryKeys.fullName: fullName,
      RestQueryKeys.gender: gender,
      RestQueryKeys.homeName: homeName,
      RestQueryKeys.id: id,
      RestQueryKeys.neighborhoodId: neighborhoodId,
      RestQueryKeys.mobilePhone: mobilePhone,
      RestQueryKeys.passportSerial: docSeries,
      RestQueryKeys.passportNumber: docNumber,
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.photo: photo,
      RestQueryKeys.pinfl: pinfl,
      RestQueryKeys.postName: postName,
      RestQueryKeys.regionId: regionId,
    };

    return await _dio.put(
      "api/mobile/v1/user/profile",
      queryParameters: params,
    );
  }

  Future<Response> checkAvailableNumber({
    required String birthDate,
    required String bioDocNumber,
    required String bioDocSeries,
    required String phoneNumber,
  }) async {
    final body = {
      RestQueryKeys.brithDate: birthDate,
      RestQueryKeys.passportNumber: bioDocNumber,
      RestQueryKeys.passportSerial: bioDocSeries,
      RestQueryKeys.phoneNumber: phoneNumber,
    };

    final response = await _dio.post("api/v2/user/profile", data: body);
    return response;
  }
}
