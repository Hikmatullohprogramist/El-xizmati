import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_query_keys.dart';

class AdService {
  final Dio _dio;

  AdService(this._dio);

  Future<Response> addAdToRecentlyViewed({required int adId}) async {
    final params = {RestQueryKeys.adId: adId};
    return _dio.post(
      'api/mobile/v1/recently-viewed/add',
      queryParameters: params,
    );
  }

  Future<Response> getRecentlyViewedAds({
    required int page,
    required int limit,
  }) {
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };
    return _dio.get(
      'api/mobile/v1/recently-viewed/getAds',
      queryParameters: params,
    );
  }
}
