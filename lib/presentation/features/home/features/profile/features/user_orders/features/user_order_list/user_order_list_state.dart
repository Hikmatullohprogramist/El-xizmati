part of 'user_order_list_cubit.dart';

@freezed
class UserOrderListState with _$UserOrderListState {
  const factory UserOrderListState({
    @Default("") String keyWord,
    @Default(LoadingState.loading) LoadingState userOrderState,
    PagingController<int, UserOrder>? controller,
    @Default(OrderType.buy) OrderType orderType,
    @Default(UserOrderStatus.ALL) UserOrderStatus userOrderStatus,
  }) = _UserOrderListState;
}

@freezed
class UserOrderListEvent with _$UserOrderListEvent {
  const factory UserOrderListEvent() = _UserOrderListEvent;
}
