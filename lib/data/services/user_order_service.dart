import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/order/order_type.dart';
import '../../domain/models/order/user_order_status.dart';
import '../constants/rest_header_keys.dart';
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
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.page: page,
      RestQueryKeys.status: userOrderStatus.name.toUpperCase()
    };
    if (orderType == OrderType.sell) {
      return _dio.get("v1/seller/orders",
          queryParameters: queryParameters, options: Options(headers: headers));
    } else {
      return _dio.get("v1/buyer/orders",
          queryParameters: queryParameters, options: Options(headers: headers));
    }
  }

  Future<Response> orderCancel(
      {required int orderId,
      required UserOrderStatus userOrderStatus,
      required String canceledNote}) async {
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.cancelNote: canceledNote,
      RestQueryKeys.status: userOrderStatus.name.toUpperCase()
    };
    final queryParameters = {RestQueryKeys.id: orderId};
    return _dio.put("mobile/v1/buyer/order",
        data: data, queryParameters: queryParameters);
  }
}
