part of 'user_order_info_cubit.dart';

@freezed
class UserOrderInfoState with _$UserOrderInfoState {
  const UserOrderInfoState._();

  const factory UserOrderInfoState({
    UserOrder? initialOrder,
    UserOrder? updatedOrder,
  }) = _UserOrderInfoState;

  UserOrder get actualOrder => updatedOrder ?? initialOrder!;
}

@freezed
class UserOrderInfoEvent with _$UserOrderInfoEvent {
  const factory UserOrderInfoEvent() = _UserOrderInfoEvent;
}
