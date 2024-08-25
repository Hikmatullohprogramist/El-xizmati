import 'dart:async';

import 'package:El_xizmati/data/datasource/network/responses/notification/app_notification_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/notification_service.dart';
import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/error/app_locale_exception.dart';
import 'package:El_xizmati/data/mappers/notification_mappers.dart';
import 'package:El_xizmati/domain/models/notification/notification.dart';

class NotificationRepository {
  final AuthPreferences _authPreferences;
  final NotificationService _notificationService;

  NotificationRepository(
    this._authPreferences,
    this._notificationService,
  );

  Future<List<AppNotification>> getAppNotifications({
    required int page,
    required int limit,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();

    final root = await _notificationService.getAppNotifications(
      page: page,
      limit: limit,
    );

    final response = AppNotificationRootResponse.fromJson(root.data);
    return response.data.results.map((e) => e.toAppNotification()).toList();
  }

  Future<void> readAppNotification(AppNotification notification) async {
    final r = await _notificationService.readAppNotification(notification.id);
    return;
  }
}
