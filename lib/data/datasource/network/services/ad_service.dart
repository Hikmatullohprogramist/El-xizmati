import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/stats/stats_type.dart';

class AdService {
  final Dio _dio;

  AdService(this._dio);

  Future<Response> getHomeAds(int page, int limit, String keyWord) {
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
      RestQueryKeys.keyWord: keyWord
    };
    return _dio.get('api/mobile/v1/home/ads?', queryParameters: params);
  }

  Future<Response> getHomePopularAds(int page, int limit) {
    final params = {RestQueryKeys.page: page, RestQueryKeys.limit: limit};
    return _dio.get('api/mobile/v1/popular/ads', queryParameters: params);
  }

  Future<Response> getAdDetail(int adId) {
    final params = {RestQueryKeys.id: adId};
    return _dio.get('api/mobile/v1/ads/detail/', queryParameters: params);
  }

  Future<Response> getAdsByAdType(AdType adType, int page, int limit) {
    String param = AdType.product == adType ? "ADS" : "SERVICE";
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
      RestQueryKeys.adType: param
    };
    return _dio.get("api/mobile/v1/home/ads", queryParameters: params);
  }

  Future<Response> getDashboardAdsByType({required AdType adType}) {
    String param = AdType.product == adType ? "ADA" : "SERVICE";
    final params = {
      RestQueryKeys.adType: param,
      RestQueryKeys.page: 1,
      RestQueryKeys.limit: 10,
    };
    return _dio.get(
      "api/mobile/v1/dashboard/popular/ads",
      queryParameters: params,
    );
  }

  Future<Response> getDashboardTopRatedAds() {
    final params = {RestQueryKeys.page: 1, RestQueryKeys.limit: 10};
    return _dio.get("api/mobile/v1/banner/ads", queryParameters: params);
  }

  Future<Response> getPopularAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) {
    String param = AdType.product == adType ? "ADA" : "SERVICE";
    final params = {
      RestQueryKeys.adType: param,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };
    return _dio.get("api/mobile/v1/popular/ads", queryParameters: params);
  }

  Future<Response> getRecentlyAdsByAdType(AdType adType) {
    String param;
    param = AdType.product == adType ? "ADA" : "SERVICE";
    final queryParameters = {RestQueryKeys.adType: param};
    return _dio.get("api/mobile/v1/home/ads", queryParameters: queryParameters);
  }

  Future<Response> getCheapAdsByAdType({
    required AdType adType,
    required int page,
    required int limit,
  }) {
    String param = AdType.product == adType ? "ADA" : "SERVICE";
    final params = {
      RestQueryKeys.adType: param,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };
    return _dio.get("api/mobile/v1/home/cheap/ads", queryParameters: params);
  }

  Future<Response> getSearchAd(String query) {
    final params = {RestQueryKeys.searchQuery: query};
    return _dio.get('api/mobile/v1/search', queryParameters: params);
  }

  Future<Response> getAdsByUser({
    required int sellerTin,
    required int page,
    required int limit,
  }) {
    final params = {
      RestQueryKeys.tin: sellerTin,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit
    };
    return _dio.get('api/mobile/v1/seller/get-ads', queryParameters: params);
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
    final params = {RestQueryKeys.adsId: adId, RestQueryKeys.type: type.name};
    return _dio.put('api/mobile/v1/ads/details', queryParameters: params);
  }

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
    final params = {RestQueryKeys.page: page, RestQueryKeys.limit: limit};
    return _dio.get(
      'api/mobile/v1/recently-viewed/getAds',
      queryParameters: params,
    );
  }
}
