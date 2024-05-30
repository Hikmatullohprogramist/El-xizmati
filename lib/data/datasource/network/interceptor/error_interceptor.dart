import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/mappers/exception_exts.dart';

@lazySingleton
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    if (statusCode == null || (statusCode < 200 && statusCode > 299)) {
      final exception = response.toAppNetworkException();
      Logger().w("onResponse s = $statusCode, r = $response, e = $exception");
      throw exception;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = err.toAppNetworkException();
    Logger().w("onError => dio e = $err app e = $exception");
    throw exception;
  }
}
