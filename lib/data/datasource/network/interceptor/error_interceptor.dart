import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:El_xizmati/data/mappers/dio_error_mappers.dart';

@lazySingleton
class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    if (statusCode == null || (statusCode < 200 && statusCode > 299)) {
      final exception = response.dioResponseToAppException();
      Logger().w("onResponse s = $statusCode, r = $response, e = $exception");
      throw exception;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = err.dioExceptionToAppException();
    Logger().w("onError => dio e = $err app e = $exception");
    throw exception;
  }
}
