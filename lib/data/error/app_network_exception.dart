import 'package:onlinebozor/data/error/app_exception.dart';

abstract class AppNetworkException implements AppException {}

class AppNetworkConnectionException implements AppNetworkException {
  final String message;
  final int statusCode;

  AppNetworkConnectionException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() {
    return "AppNetworkConnectionException: $message (Status code: $statusCode)";
  }
}

class AppNetworkDioException implements AppNetworkException {
  final String message;
  final int statusCode;

  AppNetworkDioException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() {
    return "AppNetworkDioException: $message (Status code: $statusCode)";
  }
}

class AppNetworkHttpException implements AppNetworkException {
  final String message;
  final int statusCode;

  AppNetworkHttpException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() {
    return "AppNetworkHttpException: $message (Status code: $statusCode)";
  }
}
