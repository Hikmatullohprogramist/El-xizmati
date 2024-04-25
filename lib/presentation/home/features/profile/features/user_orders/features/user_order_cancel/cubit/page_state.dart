part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    UserOrder? userOrder,
    @Default([]) List<OrderCancelReason> reasons,
    @Default(OrderCancelReason.SELLER_NOT_ANSWERED)
    OrderCancelReason cancelReason,
    @Default("") String cancelComment,
    @Default(false) bool isCommentEnabled,
    @Default(LoadingState.success) LoadingState cancelLoadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { onBackAfterCancel }
