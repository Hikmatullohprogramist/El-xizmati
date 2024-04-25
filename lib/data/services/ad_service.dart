import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../../domain/models/ad/ad_type.dart';
import '../../domain/models/stats/stats_type.dart';
import '../storages/token_storage.dart';

@lazySingleton
class AdsService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  AdsService(this._dio, this.tokenStorage);

  Future<Response> getHomeAds(int page, int limit, String keyWord) {
    final queryParameters = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
      RestQueryKeys.keyWord: keyWord
    };
    return _dio.get('api/mobile/v1/home/ads?', queryParameters: queryParameters);
  }

  Future<Response> getHomePopularAds(
    int page,
    int limit,
  ) {
    final queryParameters = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit
    };
    return _dio.get('api/mobile/v1/popular/ads', queryParameters: queryParameters);
  }

  Future<Response> getAdDetail(int adId) {
    final queryParameters = {RestQueryKeys.id: adId};
    return _dio.get('api/mobile/v1/ads/detail/', queryParameters: queryParameters);
  }

  Future<Response> getAdsByAdType(AdType adType, int page, int limit) {
    String param = AdType.PRODUCT == adType ? "ADS" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
      RestQueryKeys.adType: param
    };
    return _dio.get("api/mobile/v1/home/ads", queryParameters: queryParameters);
  }

  Future<Response> getDashboardAdsByType({required AdType adType}) {
    String param;
    param = AdType.PRODUCT == adType ? "ADA" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.adType: param,
      RestQueryKeys.page: 1,
      RestQueryKeys.limit: 10,
    };
    return _dio.get("api/mobile/v1/dashboard/popular/ads",
        queryParameters: queryParameters);
  }

  Future<Response> getDashboardTopRatedAds() {
    final queryParameters = {
      RestQueryKeys.page: 1,
      RestQueryKeys.limit: 10,
    };
    // https://api.online-bozor.uz/api/mobile/v1/banner/ads
    return _dio.get("api/mobile/v1/banner/ads", queryParameters: queryParameters);
  }

  Future<Response> getPopularAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) {
    String param;
    param = AdType.PRODUCT == adType ? "ADA" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.adType: param,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };
    return _dio.get("api/mobile/v1/popular/ads", queryParameters: queryParameters);
  }

  Future<Response> getRecentlyAdsByAdType(AdType adType) {
    String param;
    param = AdType.PRODUCT == adType ? "ADA" : "SERVICE";
    final queryParameters = {RestQueryKeys.adType: param};
    return _dio.get("api/mobile/v1/home/ads", queryParameters: queryParameters);
  }

  Future<Response> getCheapAdsByAdType({
    required AdType adType,
    required int page,
    required int limit,
  }) {
    String param;
    param = AdType.PRODUCT == adType ? "ADA" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.adType: param,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };
    return _dio.get("api/mobile/v1/home/cheap/ads", queryParameters: queryParameters);
  }

  Future<Response> getSearchAd(String query) {
    final queryParameters = {RestQueryKeys.searchQuery: query};
    return _dio.get('api/mobile/v1/search', queryParameters: queryParameters);
  }

  Future<Response> getAdsByUser({
    required int sellerTin,
    required int page,
    required int limit,
  }) {
    final queryParameters = {
      RestQueryKeys.tin: sellerTin,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit
    };
    return _dio.get('api/mobile/v1/seller/get-ads',
      queryParameters: queryParameters,
    );
  }

  Future<Response> getSimilarAds({
    required int adId,
    required int page,
    required int limit,
  }) {
    final queryParameters = {
      RestQueryKeys.adsId: adId,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit
    };
    return _dio.get('api/mobile/v1/ads/details/similar', queryParameters: queryParameters);
  }

  Future<Response> increaseAdStats({
    required StatsType type,
    required int adId,
  }) async {
    final queryParameters = {
      RestQueryKeys.adsId: adId,
      RestQueryKeys.type: type.name
    };
    return _dio.put('api/mobile/v1/ads/details', queryParameters: queryParameters);
  }

  Future<Response> addAdToRecentlyViewed({
    required int adId,
  }) async {
    final queryParameters = {RestQueryKeys.adId: adId};
    return _dio.post(
      'api/mobile/v1/recently-viewed/add',
      queryParameters: queryParameters,
    );
  }

  Future<Response> getRecentlyViewedAds({
    required int page,
    required int limit,
  }) {
    final queryParameters = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit
    };
    return _dio.get(
      'api/mobile/v1/recently-viewed/getAds',
      queryParameters: queryParameters,
    );
  }
}
