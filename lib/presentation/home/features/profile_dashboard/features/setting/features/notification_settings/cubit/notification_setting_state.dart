part of 'notification_setting_cubit.dart';

@freezed
class NotificationSettingBuildable with _$NotificationSettingBuildable {
  const factory NotificationSettingBuildable(
      {@Default(false) bool smsNotification,
      @Default(false) bool telegramNotification,
      @Default(false) bool emailNotification}) = _NotificationSettingBuildable;
}

@freezed
class NotificationSettingListenable with _$NotificationSettingListenable {
  const factory NotificationSettingListenable() = _NotificationSettingListenable;
}