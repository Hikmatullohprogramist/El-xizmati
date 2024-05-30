part of 'user_orders_cubit.dart';

@freezed
class UserOrdersState with _$UserOrdersState {
  const factory UserOrdersState({
    @Default(OrderType.sell) OrderType orderType,
  }) = _UserOrdersState;
}

@freezed
class UserOrdersEvent with _$UserOrdersEvent {
  const factory UserOrdersEvent(UserOrdersEventType type) = _UserOrdersEvent;
}

enum UserOrdersEventType {
  onOrderTypeChange,
}
