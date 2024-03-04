import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../storages/token_storage.dart';

@lazySingleton
class CartService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  CartService(this._dio, this.tokenStorage);

  Future<Response> addCart({required String adType, required int id}) {
    final queryParameters = {
      RestQueryKeys.productType: "ADS",
      RestQueryKeys.productId: id,
      RestQueryKeys.number: 1,
      RestQueryKeys.type: "BASKET"
    };
    return _dio.post("v1/buyer/product", queryParameters: queryParameters);
  }

  Future<Response> removeCart({required int adId}) {
    final queryParameters = {
      RestQueryKeys.productId: adId,
      RestQueryKeys.type: "BASKET"
    };
    return _dio.delete("v1/buyer/product", queryParameters: queryParameters);
  }

  Future<Response> getCartAllAds() {
    final queryParameters = {RestQueryKeys.type: 'BASKET'};
    return _dio.get("v1/buyer/products", queryParameters: queryParameters);
  }

  Future<Response> orderCreate({
    required int productId,
    required int amount,
    required int paymentTypeId,
    required int tin,
  }) async {
    final data = {
      RestQueryKeys.tin: tin,
      RestQueryKeys.products: [
        {
          RestQueryKeys.productId: productId,
          RestQueryKeys.amount: amount,
          RestQueryKeys.paymentTypeId: paymentTypeId,
          RestQueryKeys.deliveryAddressId: 0,
          RestQueryKeys.shippingId: 0
        }
      ]
    };
    return _dio.post('v1/buyer/order', data: data);
  }

  Future<Response> removeOrder({required int tin}) {
    final queryParameters = {RestQueryKeys.tin: tin};
    return _dio.delete("v1/buyer/products_seller", queryParameters: queryParameters);
  }
}
