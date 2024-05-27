import 'dart:io';

import 'package:dio/dio.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/error/app_network_exception.dart';

extension DioErrorExts on DioError {
  AppNetworkException errorToAppNetworkException() {
    if (error is SocketException) {
      return AppNetworkConnectionException(
        message: Strings.messageConnectionError,
        statusCode: -1,
      );
    } else if (response != null) {
      return AppNetworkHttpException(
        message: response?.statusMessage ?? Strings.messageResponseError,
        statusCode: response?.statusCode ?? -1,
      );
    } else {
      return AppNetworkDioException(
        message: message ?? "Unknown message",
        statusCode: -1,
      );
    }
  }
}

extension DioExceptionExts on DioException {
  AppNetworkException toAppNetworkException() {
    return response != null
        ? response?.toAppNetworkException() ??
            AppNetworkDioException(
              message: response?.statusMessage ?? "Unknown error",
              statusCode: response?.statusCode ?? 0,
            )
        : AppNetworkConnectionException(
            message: message ?? "Unknown error",
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
