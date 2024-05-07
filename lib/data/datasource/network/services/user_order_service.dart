import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';
import 'package:onlinebozor/data/utils/rest_mappers.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';

@lazySingleton
class UserOrderService {
  final Dio _dio;

  UserOrderService(this._dio);

  Future<Response> getUserOrders(
      {required int limit,
      required int page,
      required UserOrderStatus userOrderStatus,
      required OrderType orderType}) async {
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
