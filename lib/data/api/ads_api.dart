import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AdsApi {
  final Dio _dio;

  AdsApi(this._dio);

  Future<Response> getAdsList(int pageIndex, int pageSize) {
    final queryParameters = {'page': pageIndex, 'page_size': pageSize};
    return _dio.get('v1/home/ads?lang=la', queryParameters: queryParameters);
  }
  
  Future<Response> getPopularAds(){
    return _dio.get('v1/popular/ads');
  }
}