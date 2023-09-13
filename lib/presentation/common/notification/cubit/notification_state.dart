part of 'notification_cubit.dart';

@freezed
class NotificationBuildable with _$NotificationBuildable {
  const factory NotificationBuildable() = _NotificationBuildable;
}

@freezed
class NotificationListenable with _$NotificationListenable {
  const factory NotificationListenable(NotificationEffect effect,
      {String? message}) = _NotificationListenable;
}

enum NotificationEffect { success }
