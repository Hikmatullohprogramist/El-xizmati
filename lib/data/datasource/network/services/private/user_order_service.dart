import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';

class UserOrderService {
  final Dio _dio;

  UserOrderService(this._dio);

  Future<Response> getUserOrders({
    required int limit,
    required int page,
    required UserOrderStatus userOrderStatus,
    required OrderType orderType,
  }) async {
    final params = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.page: page,
      RestQueryKeys.status: userOrderStatus.name.toUpperCase()
    };

    if (orderType == OrderType.sell) {
      return _dio.get("api/mobile/v1/seller/orders", queryParameters: params);
    } else {
      return _dio.get("api/mobile/v1/buyer/orders", queryParameters: params);
    }
  }

  Future<Response> orderCreate({
    required int productId,
    required int amount,
    required int paymentTypeId,
    required int tin,
    required String? servicePrice,
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

  Future<Response> cancelOrder({
    required int orderId,
    required OrderCancelReason reason,
    required String comment,
  }) async {
    final body = {
      RestQueryKeys.orderId: orderId,
      RestQueryKeys.note: reason == OrderCancelReason.OTHER_REASON
          ? comment
          : reason.getRestCode(),
    };
    return _dio.put("api/mobile/v1/order/cancel", data: body);
  }
}
