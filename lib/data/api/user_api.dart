import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';

@lazySingleton
class UserApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserApi(this._dio, this.tokenStorage);

  Future<Response> getUserInformation() {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final response =
        _dio.get("v1/user/profile", options: Options(headers: headers));
    return response;
  }

  Future<Response> getRegions() async {
    final response =await _dio.get("v1/regions");
    return response;
  }

  Future<Response> getDistricts(int regionId) async {
    final queryParameters = {'region_id': regionId};
    final response =
        await _dio.get("v1/districts/list", queryParameters: queryParameters);
    return response;
  }

  Future<Response> getStreets(int districtId) async {
    final queryParameters = {'district_id': districtId};
    final response =
        await _dio.get('v1/street/list', queryParameters: queryParameters);
    return response;
  }

  Future<Response> identified(
      {required String phoneNumber,
      required String biometricSerial,
      required String biometricNumber,
      required String brithDate}) {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final data = {
      'phone_number': phoneNumber,
      "passport_serial": biometricSerial,
      "passport_number": biometricNumber,
      "birth_date": brithDate
    };
    return _dio.post('v1/user/profile',
        data: data, options: Options(headers: headers));
  }
}
