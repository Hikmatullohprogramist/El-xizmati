import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_query_keys.dart';
import 'package:El_xizmati/domain/models/stats/stats_type.dart';

class AdDetailService {
  final Dio _dio;

  AdDetailService(this._dio);

  Future<Response> getAdDetail(int adId) {
    final params = {RestQueryKeys.id: adId};
    return _dio.get('api/mobile/v1/ads/detail/', queryParameters: params);
  }

  Future<Response> getSimilarAds({
    required int adId,
    required int page,
    required int limit,
  }) {
    final params = {
      RestQueryKeys.adsId: adId,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit
    };

    return _dio.get(
      'api/mobile/v1/ads/details/similar',
      queryParameters: params,
    );
  }

  Future<Response> increaseAdStats({
    required StatsType type,
    required int adId,
  }) async {
    final params = {
      RestQueryKeys.adsId: adId,
      RestQueryKeys.type: type.name,
    };

    return _dio.put('api/mobile/v1/ads/details', queryParameters: params);
  }
}
