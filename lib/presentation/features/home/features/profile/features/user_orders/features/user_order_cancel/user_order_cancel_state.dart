part of 'user_order_cancel_cubit.dart';

@freezed
class UserOrderCancelState with _$UserOrderCancelState {
  const factory UserOrderCancelState({
    UserOrder? userOrder,
//
    @Default([]) List<OrderCancelReason> reasons,
    @Default(OrderCancelReason.SELLER_NOT_ANSWERED)
    OrderCancelReason selectedReason,
//
    @Default("") String cancelComment,
    @Default(false) bool isCommentEnabled,
//
    @Default(LoadingState.success) LoadingState loadState,
  }) = _UserOrderCancelState;
}

@freezed
class UserOrderCancelEvent with _$UserOrderCancelEvent {
  const factory UserOrderCancelEvent(UserOrderCancelEventType type) =
      _UserOrderCancelEvent;
}

enum UserOrderCancelEventType { onBackAfterCancel }
