import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../storages/token_storage.dart';

@lazySingleton
class CartService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  CartService(this._dio, this.tokenStorage);

  Future<Response> addCart({required String adType, required int id}) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryProductType: "ADS",
      RestQueryKeys.queryProductId: id,
      RestQueryKeys.queryNum: 1,
      RestQueryKeys.queryType: "BASKET"
    };
    return _dio.post("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> removeCart({required int adId}) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryProductId: adId,
      RestQueryKeys.queryType: "BASKET"
    };
    return _dio.delete("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> getCartAllAds() {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {RestQueryKeys.queryType: 'BASKET'};
    return _dio.get("v1/buyer/products",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> orderCreate(
      {required int productId,
      required int amount,
      required int paymentTypeId,
      required int tin}) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.queryTin: tin,
      RestQueryKeys.queryProducts: [
        {
          RestQueryKeys.queryProductId: productId,
          RestQueryKeys.queryAmount: amount,
          RestQueryKeys.queryPaymentTypeId: paymentTypeId,
          RestQueryKeys.queryDeliveryAddressId: 0,
          RestQueryKeys.queryShippingId: 0
        }
      ]
    };
    return _dio.post('v1/buyer/order',
        data: data, options: Options(headers: headers));
  }

  Future<Response> removeOrder({required int tin}) {
    final queryParameters = {RestQueryKeys.queryTin: tin};
    return _dio.delete("v1/buyer/products_seller",
        queryParameters: queryParameters);
  }
}
