part of 'notification_settings_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool smsNotification,
    @Default(false) bool telegramNotification,
    @Default(false) bool emailNotification,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
