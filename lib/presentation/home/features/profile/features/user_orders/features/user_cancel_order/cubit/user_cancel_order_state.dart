part of 'user_cancel_order_cubit.dart';

@freezed
class UserCancelOrderBuildable with _$UserCancelOrderBuildable {
  const factory UserCancelOrderBuildable(
      {@Default("") String keyWord,
      @Default(AppLoadingState.loading) AppLoadingState userOrderState,
      PagingController<int, UserOrderResponse>?
          userOrderPagingController,
      @Default(OrderType.buy) OrderType orderType}) = _UserCancelOrderBuildable;
}

@freezed
class UserCancelOrderListenable with _$UserCancelOrderListenable {
  const factory UserCancelOrderListenable() = _UserCancelOrderListenable;
}
