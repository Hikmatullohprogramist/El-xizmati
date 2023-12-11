import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/rest_query_keys.dart';

@lazySingleton
class UserAdService {
  final Dio _dio;

  UserAdService(this._dio);

  Future<Response> getUserAds(int pageSiz, int page) async {
    final queryParameters = {
      RestQueryKeys.queryPageSize: pageSiz,
      RestQueryKeys.queryPageIndex: page
    };
    return _dio.get("api.online-bozor.uz/api/mobile/v1/user/adsList",
        queryParameters: queryParameters);
  }
}
