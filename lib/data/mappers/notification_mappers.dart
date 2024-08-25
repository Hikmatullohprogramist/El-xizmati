import 'package:El_xizmati/data/datasource/network/responses/notification/app_notification_response.dart';
import 'package:El_xizmati/domain/models/notification/notification.dart';

extension NotificationResponseMapper on AppNotificationResponse {
  AppNotification toAppNotification() {
    return AppNotification(
      id: id,
      createdAt: createdAt,
      tinOrPinfl: tinOrPinfl,
      title: title,
      message: message,
      link: link,
      status: status,
    );
  }
}
