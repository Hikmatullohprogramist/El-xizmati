import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/repositories/user_order_repository.dart';
import 'package:onlinebozor/domain/util.dart';

import '../services/user_order_service.dart';

@LazySingleton(as: UserOrderRepository)
class UserOrderRepositoryImp extends UserOrderRepository {
  UserOrderRepositoryImp(this.userOrderService);

  final UserOrderService userOrderService;

  @override
  Future<List<UserOrderResponse>> getUserOrders(
      {required int pageSiz,
      required int pageIndex,
      required UserOrderStatus userOrderStatus,
      required OrderType orderType}) async {
    final response = await userOrderService.getUserOrders(
        pageSiz: pageSiz,
        pageIndex: pageIndex,
        userOrderStatus: userOrderStatus,
        orderType: orderType);
    final userOrderResponse =
        UserOrderRootResponse.fromJson(response.data).data.results;
    return userOrderResponse;
  }
}
