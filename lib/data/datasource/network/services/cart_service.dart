import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

@lazySingleton
class CartService {
  final Dio _dio;

  CartService(this._dio);

  Future<Response> addCart({required String adType, required int id}) {
    final params = {
      RestQueryKeys.productType: "ADS",
      RestQueryKeys.productId: id,
      RestQueryKeys.number: 1,
      RestQueryKeys.type: "BASKET"
    };
    return _dio.post("api/mobile/v1/buyer/product", queryParameters: params);
  }

  Future<Response> removeCart({required int adId}) {
    final params = {
      RestQueryKeys.productId: adId,
      RestQueryKeys.type: "BASKET"
    };
    return _dio.delete("api/mobile/v1/buyer/product", queryParameters: params);
  }

  Future<Response> getCartAllAds() {
    final params = {RestQueryKeys.type: 'BASKET'};
    return _dio.get("api/mobile/v1/buyer/products", queryParameters: params);
  }

  Future<Response> orderCreate({
    required int productId,
    required int amount,
    required int paymentTypeId,
    required int tin,
    required int? servicePrice,
  }) async {
    final body = {
      RestQueryKeys.tin: tin,
      RestQueryKeys.products: [
        {
          RestQueryKeys.productId: productId,
          RestQueryKeys.amount: amount,
          RestQueryKeys.paymentTypeId: paymentTypeId,
          RestQueryKeys.deliveryAddressId: 0,
          RestQueryKeys.shippingId: 0,
          // if (servicePrice != null && servicePrice > 0)
          "service_price": servicePrice
        }
      ]
    };
    return _dio.post('api/mobile/v1/buyer/order', data: body);
  }

  Future<Response> removeOrder({required int tin}) {
    final params = {RestQueryKeys.tin: tin};
    return _dio.delete(
      "api/mobile/v1/buyer/products_seller",
      queryParameters: params,
    );
  }
}
