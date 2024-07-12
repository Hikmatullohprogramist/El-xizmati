part of 'notification_list_cubit.dart';

@freezed
class NotificationListState with _$NotificationListState {
  const factory NotificationListState({
    PagingController<int, AppNotification>? controller,
  }) = _NotificationListState;
}

@freezed
class NotificationListEvent with _$NotificationListEvent {
  const factory NotificationListEvent() = _NotificationListEvent;
}
