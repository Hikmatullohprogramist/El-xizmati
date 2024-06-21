import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';

class AdListService {
  final Dio _dio;

  AdListService(this._dio);

  Future<Response> getAdsByCategory(int page, int limit, String key) {
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
      RestQueryKeys.keyWord: key
    };

    return _dio.get('api/mobile/v1/home/ads?', queryParameters: params);
  }

  Future<Response> getAdsByAdType(AdType adType, int page, int limit) {
    String adTypeParam = AdType.product == adType ? "ADS" : "SERVICE";
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
      RestQueryKeys.adType: adTypeParam
    };

    return _dio.get("api/mobile/v1/home/ads", queryParameters: params);
  }

  Future<Response> getDashboardAdsByType({required AdType adType}) {
    String adTypeParam = AdType.product == adType ? "ADA" : "SERVICE";
    final params = {
      RestQueryKeys.adType: adTypeParam,
      RestQueryKeys.page: 1,
      RestQueryKeys.limit: 10,
    };

    return _dio.get(
      "api/mobile/v1/dashboard/popular/ads",
      queryParameters: params,
    );
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

  Future<Response> getPopularAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) {
    String adTypeParam = AdType.product == adType ? "ADA" : "SERVICE";
    final params = {
      RestQueryKeys.adType: adTypeParam,
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };

    return _dio.get("api/mobile/v1/popular/ads", queryParameters: params);
  }
}
