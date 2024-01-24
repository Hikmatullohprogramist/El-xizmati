import '../../data/responses/user_order/user_order_response.dart';
import '../models/order/order_type.dart';
import '../models/order/user_order_status.dart';

abstract class UserOrderRepository {
  Future<List<UserOrderResponse>> getUserOrders({
    required int limit,
    required int page,
    required UserOrderStatus userOrderStatus,
    required OrderType orderType,
  });
}
