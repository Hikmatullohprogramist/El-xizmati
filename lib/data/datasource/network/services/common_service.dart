import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

@lazySingleton
class CommonService {
  final Dio _dio;

  CommonService(this._dio);

  Future<Response> getBanners() {
    return _dio.get('api/mobile/v1/home/banners');
  }

  Future<Response> getCategories() {
    return _dio.get('api/mobile/v1/categories');
  }

  Future<Response> getPopularCategories(int pageIndex, int pageSize) {
    final queryParameters = {
      RestQueryKeys.page: pageIndex,
      RestQueryKeys.limit: pageSize
    };
    return _dio.get("api/mobile/v1/popular/categories",
        queryParameters: queryParameters);
  }

  Future<Response> getCurrencies() {
    return _dio.get('api/mobile/v1/currencies');
  }
}
