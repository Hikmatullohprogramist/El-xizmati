import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

@lazySingleton
class AdsApi {
  final Dio _dio;

  AdsApi(this._dio);

  Future<Response> getHomeAds(int pageIndex, int pageSize, String keyWord) {
    final queryParameters = {
      'page': pageIndex,
      'page_size': pageSize,
      'key_word': keyWord
    };
    return _dio.get('v1/home/ads?', queryParameters: queryParameters);
  }

  Future<Response> getHomePopularAds() {
    return _dio.get('v1/popular/ads');
  }

  Future<Response> getAdDetail(int adId) {
    final queryParameters = {
      'id': adId,
    };
    return _dio.get('v1/ads/detail/', queryParameters: queryParameters);
  }

  Future<Response> getCollectiveAds(CollectiveType collectiveType,
      int pageIndex, int pageSize, String keyWord) {
    String param;
    if (CollectiveType.commodity == collectiveType) {
      param = "ADS";
    } else {
      param = "SERVICE";
    }
    final queryParameters = {
      'page': pageIndex,
      'page_size': pageSize,
      'key_word': keyWord,
      'param': param
    };
    return _dio.get("v1/home/ads?", queryParameters: queryParameters);
  }

  Future<Response> getCollectivePopularAds(CollectiveType collectiveType) {
    String param;
    if (CollectiveType.commodity == collectiveType) {
      param = "ADS";
    } else {
      param = "SERVICE";
    }
    final queryParameters = {'param': param};
    return _dio.get("v1/home/ads?", queryParameters: queryParameters);
  }

  Future<Response> getCollectiveHotDiscountAds(CollectiveType collectiveType) {
    String param;
    if (CollectiveType.commodity == collectiveType) {
      param = "ADS";
    } else {
      param = "SERVICE";
    }
    final queryParameters = {'param': param};
    return _dio.get("v1/home/ads?", queryParameters: queryParameters);
  }

  Future<Response> getSearchAd(String query) {
    final queryParameters = {
      'q': query,
    };
    return _dio.get('v1/search', queryParameters: queryParameters);
  }

  Future<Response> getAds(
    CollectiveType collectiveType,
    int pageIndex,
    int pageSize,
    String keyWord,
  ) {
    return _dio.get("");
  }
}
