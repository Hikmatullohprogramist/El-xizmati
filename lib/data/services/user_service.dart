import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../storages/token_storage.dart';

@lazySingleton
class UserService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserService(this._dio, this.tokenStorage);

  Future<Response> getFullUserInfo() {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final response =
        _dio.get("v1/user/profile", options: Options(headers: headers));
    return response;
  }

  Future<Response> getBiometricInfo(
      {required String phoneNumber,
      required String biometricSerial,
      required String biometricNumber,
      required String brithDate}) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.queryPhoneNumber: phoneNumber,
      RestQueryKeys.queryPassportSerial: biometricSerial,
      RestQueryKeys.queryPassportNumber: biometricNumber,
      RestQueryKeys.queryBrithDate: brithDate
    };
    return _dio.post('v1/user/profile',
        data: data, options: Options(headers: headers));
  }

  Future<Response> getUserInfo({
    required String secretKey,
    required String phoneNumber,
  }) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.querySecretKey: secretKey,
      RestQueryKeys.queryPhoneNumber: phoneNumber
    };
    return _dio.post('v1/user/profile/verify/in_progress',
        data: data, options: Options(headers: headers));
  }

  Future<Response> sendUserInformation({
    required String email,
    required String gender,
    required String homeName,
    required int id,
    required int mahallaId,
    required String mobilePhone,
    required String photo,
    required int pinfl,
    required String postName,
    required String phoneNumber,
  }) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryEmail: email,
      RestQueryKeys.queryGender: gender,
      RestQueryKeys.queryHomeName: homeName,
      RestQueryKeys.queryId: id,
      RestQueryKeys.queryMahallaId: mahallaId,
      RestQueryKeys.queryMobilePhone: mobilePhone,
      RestQueryKeys.queryPhoto: photo,
      RestQueryKeys.queryPnifl: pinfl,
      RestQueryKeys.queryPostName: postName,
      RestQueryKeys.queryPhoneNumber: phoneNumber
    };
    final response = await _dio.put("v1/user/profile",
        queryParameters: queryParameters, options: Options(headers: headers));
    return response;
  }

  Future<Response> getRegions() async {
    final response = await _dio.get("v1/regions");
    return response;
  }

  Future<Response> getDistricts(int regionId) async {
    final queryParameters = {RestQueryKeys.queryRegionId: regionId};
    final response =
        await _dio.get("v1/districts/list", queryParameters: queryParameters);
    return response;
  }

  Future<Response> getStreets(int districtId) async {
    final queryParameters = {RestQueryKeys.queryDistrictId: districtId};
    final response =
        await _dio.get('v1/street/list', queryParameters: queryParameters);
    return response;
  }
}
