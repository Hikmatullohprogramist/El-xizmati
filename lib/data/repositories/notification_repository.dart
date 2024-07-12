import 'dart:async';

import 'package:onlinebozor/data/datasource/network/responses/notification/app_notification_response.dart';
import 'package:onlinebozor/data/datasource/network/services/private/notification_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/mappers/notification_mappers.dart';
import 'package:onlinebozor/domain/models/notification/notification.dart';

class NotificationRepository {
  final AuthPreferences _authPreferences;
  final NotificationService _notificationService;

  NotificationRepository(
    this._authPreferences,
    this._notificationService,
  );

  Future<List<AppNotification>> getNotifications({
    required int page,
    required int limit,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();

    final root = await _notificationService.getNotifications(
      page: page,
      limit: limit,
    );

    final response = AppNotificationRootResponse.fromJson(root.data);
    return response.data.results.map((e) => e.toAppNotification()).toList();
  }

  Future<void> markAsRead(AppNotification notification) async {
    final response = await _notificationService.markAsRead(notification.id);
    return;
  }
}
