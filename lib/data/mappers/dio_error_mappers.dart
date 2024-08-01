import 'dart:io';

import 'package:dio/dio.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/error/app_exception.dart';
import 'package:onlinebozor/data/error/app_network_exception.dart';

extension DioErrorExts on DioError {
  AppNetworkException dioErrorToAppException() {
    if (error is SocketException) {
      return AppNetworkConnectionException(
        message: Strings.messageConnectionError,
        statusCode: -499,
      );
    }

    if (error is AppNetworkException) {
      return error as AppNetworkException;
    }

    if (response != null) {
      return AppNetworkHttpException(
        message: response?.statusMessage ?? Strings.messageResponseError,
        statusCode: response?.statusCode ?? -488,
      );
    }

    return AppNetworkDioException(
      message: message ?? "Unknown message",
      statusCode: -477,
    );
  }
}

extension DioExceptionExts on DioException {
  AppNetworkException dioExceptionToAppException() {
    if (error is AppNetworkException) {
      return error as AppNetworkException;
    }

    return response != null
        ? AppNetworkDioException(
            message: response?.statusMessage ??
                response?.toString() ??
                message ??
                "Unknown error",
            statusCode: response?.statusCode ?? -466,
          )
        : AppNetworkConnectionException(
            message: message ?? "Unknown error",
            statusCode: -455,
          );
  }
}

extension DioResponseExceptionExts on Response {
  AppNetworkException dioResponseToAppException() {
    return AppNetworkHttpException(
      message: statusMessage ?? "Unknown error",
      statusCode: statusCode ?? -444,
    );
  }
}

extension ObjectExceptionExts on Object {
  AppException objectToAppException(StackTrace? stackTrace) {
    if (this is AppException) {
      return this as AppException;
    }
    if (this is DioError) {
      return (this as DioError).dioErrorToAppException();
    }
    if (this is DioException) {
      return (this as DioException).dioExceptionToAppException();
    }

    return AppNetworkDioException(message: "Unknown error", statusCode: 1);
  }
}
