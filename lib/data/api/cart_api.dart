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

  Future<Response> orderCreate(
      {required int productId,
      required int amount,
      required int paymentTypeId}) async {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'product_id': productId,
      'amount': amount,
      "payment_type_id": paymentTypeId,
      "delivery_address_id": 0,
      "shipping_id": 0
    };
    return _dio.post('v1/buyer/order',
        queryParameters: queryParameters, options: Options(headers: headers));
  }
//
// /mobile/v1/buyer/order  POST
//
// products:[
// {
// "product_id": 5190,
// "amount": 4,
// "payment_type_id": 1,
// "delivery_address_id": 0,
// "shipping_id": 0
// }
// ]
}
