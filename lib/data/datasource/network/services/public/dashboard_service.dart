import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_query_keys.dart';

class DashboardService {
  final Dio _dio;

  DashboardService(this._dio);

  Future<Response> getBanners() {
    return _dio.get('api/mobile/v1/home/banners');
  }

  Future<Response> getCatalogCategories() {
    return _dio.get('api/mobile/categories/');
  }

  Future<Response> getPopularCategories(int page, int limit) {
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };

    return _dio.get(
      "api/mobile/v1/popular/categories",
      queryParameters: params,
    );
  }

  Future<Response> getPopularAds(int page, int limit) {
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
    };

    return _dio.get('api/mobile/v1/popular/ads', queryParameters: params);
  }

  Future<Response> getDashboardTopRatedAds() {
    final params = {
      RestQueryKeys.page: 1,
      RestQueryKeys.limit: 10,
    };

    return _dio.get("api/mobile/v1/banner/ads", queryParameters: params);
  }
}
