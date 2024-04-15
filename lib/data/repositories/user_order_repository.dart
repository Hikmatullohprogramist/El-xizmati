import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_order/user_order_response.dart';

import '../../data/services/user_order_service.dart';
import '../../domain/models/order/order_type.dart';
import '../../domain/models/order/user_order_status.dart';

@LazySingleton()
class UserOrderRepository {
  UserOrderRepository(this.userOrderService);

  final UserOrderService userOrderService;

  @override
  Future<List<UserOrder>> getUserOrders({
    required int page,
    required int limit,
    required UserOrderStatus userOrderStatus,
    required OrderType orderType,
  }) async {
    final response = await userOrderService.getUserOrders(
      page: page,
      limit: limit,
      userOrderStatus: userOrderStatus,
      orderType: orderType,
    );
    final orders = UserOrderRootResponse.fromJson(response.data).data.results;
    return orders;
  }
}
