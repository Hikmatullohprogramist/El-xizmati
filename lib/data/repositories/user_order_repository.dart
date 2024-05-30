import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/data/datasource/network/services/user_order_service.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';

// @LazySingleton()
class UserOrderRepository {
  final TokenPreferences _tokenPreferences;
  final UserOrderService _userOrderService;
  final UserPreferences _userPreferences;

  UserOrderRepository(
    this._tokenPreferences,
    this._userOrderService,
    this._userPreferences,
  );

  Future<List<UserOrder>> getUserOrders({
    required int page,
    required int limit,
    required UserOrderStatus userOrderStatus,
    required OrderType orderType,
  }) async {
    if (_tokenPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final response = await _userOrderService.getUserOrders(
      page: page,
      limit: limit,
      userOrderStatus: userOrderStatus,
      orderType: orderType,
    );
    final orders = UserOrderRootResponse.fromJson(response.data).data.results;
    return orders;
  }

  Future<void> cancelOrder({
    required int orderId,
    required OrderCancelReason reason,
    required String comment,
  }) async {
    final response = await _userOrderService.cancelOrder(
      orderId: orderId,
      reason: reason,
      comment: comment,
    );
    return;
  }
}
