import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CommonApi {
  final Dio _dio;

  CommonApi(this._dio);

  Future<Response> getBanners() {
    return _dio.get('v1/home/banners');
  }

  Future<Response> getCategories() {
    return _dio.get('v1/categories');
  }

  Future<Response> getPopularCategories(int pageIndex, int pageSize) {
    final queryParameters = {'page': pageIndex, 'page_size': pageSize};
    return _dio.get("v1/popular/categories", queryParameters: queryParameters);
  }

  Future<Response> getCurrency() {
    return _dio.get('v1/currencies');
  }
}
