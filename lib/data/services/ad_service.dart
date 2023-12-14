import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';
import 'package:onlinebozor/domain/util.dart';
import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

@lazySingleton
class AdsService {
  final Dio _dio;

  AdsService(this._dio);

  Future<Response> getHomeAds(int pageIndex, int pageSize, String keyWord) {
    final queryParameters = {
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize,
      RestQueryKeys.queryKeyWord: keyWord
    };
    return _dio.get('v1/home/ads?', queryParameters: queryParameters);
  }

  Future<Response> getHomePopularAds(
    int pageIndex,
    int pageSize,
  ) {
    final queryParameters = {
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize
    };
    return _dio.get('v1/popular/ads', queryParameters: queryParameters);
  }

  Future<Response> getAdDetail(int adId) {
    final queryParameters = {RestQueryKeys.queryId: adId};
    return _dio.get('v1/ads/detail/', queryParameters: queryParameters);
  }

  Future<Response> getCollectiveAds(
      CollectiveType collectiveType, int pageIndex, int pageSize) {
    String param = CollectiveType.product == collectiveType ? "ADS" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize,
      RestQueryKeys.queryCollectiveTypeAds: param
    };
    return _dio.get("v1/home/ads", queryParameters: queryParameters);
  }

  Future<Response> getCollectivePopularAds({
    required CollectiveType collectiveType,
    required int pageIndex,
    required int pageSize,
  }) {
    String param;
    param = CollectiveType.product == collectiveType ? "ADA" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.queryCollectiveTypeAds: param,
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize,
    };
    return _dio.get("v1/home/ads", queryParameters: queryParameters);
  }

  Future<Response> getCollectiveRecentlyAds(CollectiveType collectiveType) {
    String param;
    param = CollectiveType.product == collectiveType ? "ADA" : "SERVICE";
    final queryParameters = {RestQueryKeys.queryCollectiveTypeAds: param};
    return _dio.get("v1/home/ads", queryParameters: queryParameters);
  }

  Future<Response> getCollectiveCheapAds({
    required CollectiveType collectiveType,
    required int pageIndex,
    required int pageSize,
  }) {
    String param;
    param = CollectiveType.product == collectiveType ? "ADA" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.queryCollectiveTypeAds: param,
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize,
    };
    return _dio.get("v1/home/cheap/ads", queryParameters: queryParameters);
  }

  Future<Response> getCollectiveHotDiscountAds(CollectiveType collectiveType) {
    String param;
    param = CollectiveType.product == collectiveType ? "ADA" : "SERVICE";
    final queryParameters = {RestQueryKeys.queryCollectiveTypeAds: param};
    return _dio.get("v1/home/ads?", queryParameters: queryParameters);
  }

  Future<Response> getSearchAd(String query) {
    final queryParameters = {RestQueryKeys.querySearchQuery: query};
    return _dio.get('v1/search', queryParameters: queryParameters);
  }

  Future<Response> getSellerAds({
    required int sellerTin,
    required int pageIndex,
    required int pageSize,
  }) {
    final queryParameters = {
      RestQueryKeys.queryTin: sellerTin,
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize
    };
    return _dio.get(
      'v1/seller/ads',
      queryParameters: queryParameters,
    );
  }

  Future<Response> getSimilarAds({
    required int adId,
    required int pageIndex,
    required int pageSize,
  }) {
    final queryParameters = {
      RestQueryKeys.queryAdsId: adId,
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize
    };
    return _dio.get('v1/ads/details/similar', queryParameters: queryParameters);
  }

  Future<Response> setViewAd(
      {required ViewType type, required int adId}) async {
    final queryParameters = {
      RestQueryKeys.queryAdsId: adId,
      RestQueryKeys.queryType: type
    };
    return _dio.put('v1/ads/details', queryParameters: queryParameters);
  }
}
