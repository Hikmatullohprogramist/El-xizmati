import 'package:El_xizmati/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:El_xizmati/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_order_service.dart';
import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/datasource/preference/user_preferences.dart';
import 'package:El_xizmati/data/error/app_locale_exception.dart';
import 'package:El_xizmati/data/mappers/user_order_mappers.dart';
import 'package:El_xizmati/data/repositories/cart_repository.dart';
import 'package:El_xizmati/domain/models/order/order_cancel_reason.dart';
import 'package:El_xizmati/domain/models/order/order_type.dart';
import 'package:El_xizmati/domain/models/order/user_order.dart';
import 'package:El_xizmati/domain/models/order/user_order_status.dart';

class UserOrderRepository {
  final AuthPreferences _authPreferences;
  final CartRepository _cartRepository;
  final UserEntityDao _userEntityDao;
  final UserOrderService _userOrderService;
  final UserPreferences _userPreferences;

  UserOrderRepository(
    this._authPreferences,
    this._cartRepository,
    this._userEntityDao,
    this._userOrderService,
    this._userPreferences,
  );

  Future<List<UserOrder>> getUserOrders({
    required int page,
    required int limit,
    required UserOrderStatus userOrderStatus,
    required OrderType orderType,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final response = await _userOrderService.getUserOrders(
      page: page,
      limit: limit,
      userOrderStatus: userOrderStatus,
      orderType: orderType,
    );
    final orders = UserOrderRootResponse.fromJson(response.data).data.results;
    return orders.map((e) => e.toOrder()).toList();
  }

  Future<void> orderCreate({
    required int adId,
    required int amount,
    required int paymentTypeId,
    required int tin,
    required String? servicePrice,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    var user = await _userEntityDao.getUser();
    var neighborhoodId = user?.neighborhoodId ?? 0;

    await _userOrderService.orderCreate(
      productId: adId,
      amount: amount,
      paymentTypeId: paymentTypeId,
      tin: tin,
      neighborhoodId: neighborhoodId,
      servicePrice: servicePrice,
    );

    await removeOrder(tin: tin);
    await _cartRepository.removeFromCart(adId);
  }

  Future<void> removeOrder({required int tin}) async {
    _userOrderService.removeOrder(tin: tin);
    return;
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
