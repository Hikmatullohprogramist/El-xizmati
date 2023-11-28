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

  Future<Response> removeCart({required int adId}) {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'id': adId,
    };
    return _dio.delete("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> getCartAllAds() {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'type': 'BASKET',
    };
    return _dio.get("v1/buyer/products",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> orderCreate(
      {required int productId,
      required int amount,
      required int paymentTypeId}) async {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final data = {
      'product_id': productId,
      'amount': amount,
      "payment_type_id": paymentTypeId,
      "delivery_address_id": 0,
      "shipping_id": 0
    };
    return _dio.post('v1/buyer/order',
        data: data, options: Options(headers: headers));
  }
}
