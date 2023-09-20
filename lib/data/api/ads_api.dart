import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AdsApi {
  final Dio _dio;

  AdsApi(this._dio);

  Future<Response> getAdsList(int pageIndex, int pageSize) {
    final body = {'page': pageIndex, 'page_size':pageSize};
    return _dio.post('v1/home/ads?lang=la', data: body);
  }
}