import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../storage/token_storage.dart';

@lazySingleton
class FavoriteApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  FavoriteApi(this._dio, this.tokenStorage);

  Future<Response> addFavorite({required String adType, required int id}) {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'product_type': "ADS",
      'product_id': id,
      'num': 1,
      "type": "SELECTED"
    };
    return _dio.post("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> deleteFavorite(int adId) {
    final queryParameters = {'product_id': adId, "type": "SELECTED"};
    return _dio.delete("v1/buyer/products", queryParameters: queryParameters);
  }

  Future<Response> getFavoriteAds() {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'type': "SELECTED",
    };
    return _dio.get("v1/buyer/products",
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}
