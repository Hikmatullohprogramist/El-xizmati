import 'package:dio/dio.dart';
import 'package:onlinebozor/data/error/app_network_exception.dart';

extension DioExceptionExts on DioException {
  AppNetworkException toAppNetworkException() {
    return response != null
        ? response?.toAppNetworkException() ??
            AppNetworkDioException(
              message: response?.statusMessage ?? "Unknown error",
              statusCode: response?.statusCode ?? 0,
            )
        : AppNetworkConnectionException(
            message: message ?? "",
            statusCode: 0,
          );
  }
}

extension DioResponseExts on Response {
  AppNetworkException toAppNetworkException() {
    return AppNetworkHttpException(
      message: statusMessage ?? "Unknown error",
      statusCode: statusCode ?? 0,
    );
  }
}
