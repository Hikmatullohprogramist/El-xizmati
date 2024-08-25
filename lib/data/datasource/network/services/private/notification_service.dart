import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_query_keys.dart';

class NotificationService {
  final Dio _dio;

  NotificationService(this._dio);

  Future<Response> getAppNotifications({
    required int page,
    required int limit,
  }) {
    final params = {
      RestQueryKeys.page: page,
      RestQueryKeys.limit: limit,
      // "from_date": "2024-07-12",
      // "to_day":"2024-07-12",
      // "status":"UNREAD",
    };
    // https://api.online-bozor.uz/api/mobile/v2/notification?page=1&page_size=2&from_date=2024-07-11&to_day=2024-07-11&status=UNREAD'

    return _dio.get(
      "api/mobile/v2/notification",
      queryParameters: params,
    );
  }

  Future<Response> readAppNotification(int notificationId) {
    final params = {"id": notificationId};

    return _dio.put(
      "api/mobile/v1/notification",
      queryParameters: params,
    );
  }
}
