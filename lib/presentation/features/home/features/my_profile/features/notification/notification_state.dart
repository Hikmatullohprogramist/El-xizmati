part of'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(0) int something
}) = _NotificationState;

  factory NotificationState.fromJson(Map<String, Object?> json) => _$NotificationStateFromJson(json);
}
@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent() = _NotificationEvent;
  factory NotificationEvent.fromJson(Map<String, Object?> json) => _$NotificationEventFromJson(json);

}

