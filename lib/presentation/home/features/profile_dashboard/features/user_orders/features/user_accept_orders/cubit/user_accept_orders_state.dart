part of 'user_accept_orders_cubit.dart';

@freezed
class UserAcceptOrdersBuildable with _$UserAcceptOrdersBuildable {
  const factory UserAcceptOrdersBuildable(
          {@Default("") String keyWord,
          @Default(AppLoadingState.loading) AppLoadingState userOrderState,
          PagingController<int, UserOrderResponse>? userOrderPagingController,
          @Default(OrderType.buy) OrderType orderType}) =
      _UserAcceptOrdersBuildable;
}

@freezed
class UserAcceptOrdersListenable with _$UserAcceptOrdersListenable {
  const factory UserAcceptOrdersListenable() = _UserAcceptOrdersListenable;
}
