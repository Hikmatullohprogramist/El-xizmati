import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FavoriteApi {
  final Dio _dio;

  FavoriteApi(this._dio);

  Future<Response> addFavorite({required String adType, required int id}) {
    final queryParameters = {
      'product_type': "ADS",
      'product_id': id,
      'num': 1,
      "type": "SELECTED"
    };
    return _dio.post("v1/buyer/product", queryParameters: queryParameters);
  }

  Future<Response> addFavorites() {
    return _dio.post("v1/buyer/products");
  }

  Future<Response> deleteFavorite() {
    return _dio.post("v1/buyer/products");
  }

  Future<Response> getFavoriteAds(){
    return _dio.get("");
  }
}
