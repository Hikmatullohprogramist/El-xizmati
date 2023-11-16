import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../storage/token_storage.dart';

@lazySingleton
class CartApi {
  Dio _dio;
  final TokenStorage tokenStorage;

  CartApi(this._dio, this.tokenStorage);

  Future<Response> addCart({required String adType, required int id}) {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'product_type': "ADS",
      'product_id': id,
      'num': 1,
      "type": "BASKET"
    };
    return _dio.post("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}
