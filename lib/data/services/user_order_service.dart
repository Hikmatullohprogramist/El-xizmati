import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/utils/rest_mappers.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';

import '../../domain/models/order/order_type.dart';
import '../../domain/models/order/user_order_status.dart';
import '../constants/rest_query_keys.dart';
import '../storages/token_storage.dart';

@lazySingleton
class UserOrderService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserOrderService(this._dio, this.tokenStorage);

  Future<Response> getUserOrders(
      {required int limit,
      required int page,
      required UserOrderStatus userOrderStatus,
      required OrderType orderType}) async {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.page: page,
      RestQueryKeys.status: userOrderStatus.name.toUpperCase()
    };
    if (orderType == OrderType.sell) {
      return _dio.get("api/mobile/v1/seller/orders",
          queryParameters: queryParameters);
    } else {
      return _dio.get("api/mobile/v1/buyer/orders",
          queryParameters: queryParameters);
    }
  }

  Future<Response> cancelOrder({
    required int orderId,
    required OrderCancelReason reason,
    required String comment,
  }) async {
    final data = {
      RestQueryKeys.orderId: orderId,
      RestQueryKeys.note: reason == OrderCancelReason.OTHER_REASON
          ? comment
          : reason.getRestCode(),
    };
    return _dio.put("api/mobile/v1/order/cancel", data: data);
  }
}
