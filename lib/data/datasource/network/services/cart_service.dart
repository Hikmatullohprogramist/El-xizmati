import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

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
    required int neighborhoodId,
  }) async {
    //   {
    //     "tin": 30101976240049,
    //   "products": [
    // {
    //   "product_id": 10064,
    //   "amount": 1,
    //   "payment_type_id": 1,
    //   "delivery_address_id": 0,
    //   "shipping_id": 0,
    //   "servise_price": "14100",
    //   "is_saved": true
    // }
    //   ],
    //   "payment_type_id": 1,
    //   "buyer_mahalla_id": 607012
    // }
    final body = {
      RestQueryKeys.tin: tin,
      RestQueryKeys.paymentTypeId: paymentTypeId,
      "buyer_mahalla_id": neighborhoodId,
      RestQueryKeys.products: [
        {
          RestQueryKeys.productId: productId,
          RestQueryKeys.amount: amount,
          RestQueryKeys.paymentTypeId: paymentTypeId,
          RestQueryKeys.deliveryAddressId: 0,
          RestQueryKeys.shippingId: 0,
          RestQueryKeys.servicePrice: servicePrice
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
