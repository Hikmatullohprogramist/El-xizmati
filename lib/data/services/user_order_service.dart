import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/util.dart';
import '../constants/rest_header_keys.dart';
import '../constants/rest_query_keys.dart';
import '../storages/token_storage.dart';

@lazySingleton
class UserOrderService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserOrderService(this._dio, this.tokenStorage);

  Future<Response> getUserOrders(
      {required int pageSiz,
      required int pageIndex,
      required UserOrderStatus userOrderStatus,
      required OrderType orderType}) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryPageSize: pageSiz,
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryStatus: userOrderStatus.name.toUpperCase()
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
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final data = {
      RestQueryKeys.queryCancelNote: canceledNote,
      RestQueryKeys.queryStatus: userOrderStatus.name.toUpperCase()
    };
    final queryParameters = {RestQueryKeys.queryId: orderId};
    return _dio.put("mobile/v1/buyer/order",
        data: data, queryParameters: queryParameters);
  }
}
