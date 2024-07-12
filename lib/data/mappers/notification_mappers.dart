import 'package:onlinebozor/data/datasource/network/responses/notification/app_notification_response.dart';
import 'package:onlinebozor/domain/models/notification/notification.dart';

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
