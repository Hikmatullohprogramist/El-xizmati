part of 'user_reject_orders_cubit.dart';

@freezed
class UserRejectOrdersBuildable with _$UserRejectOrdersBuildable {
  const factory UserRejectOrdersBuildable(
          {@Default("") String keyWord,
          @Default(LoadingState.loading) LoadingState userOrderState,
          PagingController<int, UserOrderResponse>?
              userOrderPagingController,
          @Default(OrderType.buy) OrderType orderType}) =
      _UserRejectOrdersBuildable;
}

@freezed
class UserRejectOrdersListenable with _$UserRejectOrdersListenable {
  const factory UserRejectOrdersListenable() = _UserRejectOrdersListenable;
}
