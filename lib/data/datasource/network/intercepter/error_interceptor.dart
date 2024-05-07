import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/error/network_exception.dart';

@lazySingleton
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Check for non-2xx status codes
    if (response.statusCode == null ||
        !(response.statusCode! >= 200 && response.statusCode! <= 299)) {
      throw NetworkException(
        message: response.statusMessage ?? "Unknown error",
        statusCode: response.statusCode ?? 0,
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      // Throw an ApiException with the response data
      throw NetworkException(
        message: err.response?.statusMessage ?? "Unknown error",
        statusCode: err.response?.statusCode ?? 0,
      );
    } else {
      // Handle other errors (network issues, timeout, etc.)
      throw NetworkException(
        message: err.message ?? "",
        statusCode: 0,
      );
    }
  }
}
