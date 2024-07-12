import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

class RegionService {
  final Dio _dio;

  RegionService(this._dio);

  Future<Response> getRegionAndDistricts() async {
    return _dio.get("api/mobile/v1/regions-districts");
  }

  Future<Response> getRegions() {
    return _dio.get("api/mobile/v1/regions");
  }

  Future<Response> getDistricts(int regionId) {
    final params = {RestQueryKeys.regionId: regionId};

    return _dio.get(
      "api/mobile/v1/districts/list",
      queryParameters: params,
    );
  }

  Future<Response> getNeighborhoods(int districtId) {
    final params = {RestQueryKeys.districtId: districtId};

    return _dio.get(
      'api/mobile/v1/street/list',
      queryParameters: params,
    );
  }
}
