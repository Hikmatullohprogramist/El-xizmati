part of 'user_order_list_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String keyWord,
    @Default(LoadingState.loading) LoadingState userOrderState,
    PagingController<int, UserOrder>? controller,
    @Default(OrderType.buy) OrderType orderType,
    @Default(UserOrderStatus.ALL) UserOrderStatus userOrderStatus,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
