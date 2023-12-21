import 'package:onlinebozor/domain/util.dart';

import '../../data/responses/user_order/user_order_response.dart';

abstract class UserOrderRepository {
  Future<List<UserOrderResponse>> getUserOrders(
      {required int pageSiz,
      required int pageIndex,
      required UserOrderStatus userOrderStatus,
      required OrderType orderType});
}
