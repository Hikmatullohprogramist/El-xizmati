import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AdsApi {
  final Dio _dio;

  AdsApi(this._dio);

  Future<Response> getAdsList(int pageIndex, int pageSize, String keyWord) {
    final queryParameters = {
      'page': pageIndex,
      'page_size': pageSize,
      'key_word': keyWord
    };
    return _dio.get('v1/home/ads?', queryParameters: queryParameters);
  }

  Future<Response> getPopularAds() {
    return _dio.get('v1/popular/ads');
  }

  Future<Response> getAdDetail(int adId) {
    final queryParameters = {
      'id': adId,
    };
    return _dio.get('v1/ads/detail/', queryParameters: queryParameters);
  }
}
