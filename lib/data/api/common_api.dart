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
    return _dio.get('v1/categories?lang=uz');
  }

  Future<Response> getPopularCategories(int pageIndex, int pageSize) {
    final queryParameters = {'page': pageIndex, 'count': pageSize};
    return _dio.get("v1/popular/categories", queryParameters: queryParameters);
  }
}
