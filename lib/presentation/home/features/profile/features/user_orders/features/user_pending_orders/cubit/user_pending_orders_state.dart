part of 'user_pending_orders_cubit.dart';

@freezed
class UserPendingOrdersBuildable with _$UserPendingOrdersBuildable {
  const factory UserPendingOrdersBuildable(
          {@Default("") String keyWord,
          @Default(LoadingState.loading) LoadingState userOrderState,
          PagingController<int, UserOrderResponse>?
              userOrderPagingController,
          @Default(OrderType.buy) OrderType orderType}) =
      _UserPendingOrdersBuildable;
}

@freezed
class UserPendingOrdersListenable with _$UserPendingOrdersListenable {
  const factory UserPendingOrdersListenable() = _UserPendingOrdersListenable;
}