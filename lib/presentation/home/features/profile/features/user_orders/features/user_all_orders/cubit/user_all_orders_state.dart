part of 'user_all_orders_cubit.dart';

@freezed
class UserAllOrdersBuildable with _$UserAllOrdersBuildable {
  const factory UserAllOrdersBuildable(
      {@Default("") String keyWord,
      @Default(LoadingState.loading) LoadingState userOrderState,
      PagingController<int, UserOrderResponse>?
          userOrderPagingController,
      @Default(OrderType.buy) OrderType orderType}) = _UserAllOrdersBuildable;
}

@freezed
class UserAllOrdersListenable with _$UserAllOrdersListenable {
  const factory UserAllOrdersListenable() = _UserAllOrdersListenable;
}
