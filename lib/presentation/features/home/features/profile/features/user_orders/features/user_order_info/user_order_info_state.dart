part of 'user_order_info_cubit.dart';

@freezed
class UserOrderInfoState with _$UserOrderInfoState {
  const factory UserOrderInfoState({
    UserOrder? userOrder,
  }) = _UserOrderInfoState;
}

@freezed
class UserOrderInfoEvent with _$UserOrderInfoEvent {
  const factory UserOrderInfoEvent() = _UserOrderInfoEvent;
}
