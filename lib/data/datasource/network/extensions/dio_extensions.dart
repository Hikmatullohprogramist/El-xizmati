import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

extension DioExts on Dio {
  Dio setupDefaultParams(List<Interceptor> externalInterceptors) {
    options = _getBaseOptions(Constants.baseUrl);
    interceptors.addAll(externalInterceptors);
    interceptors.add(_loggerInterceptor);
    interceptors.add(_headerInterceptor);
    interceptors.add(ChuckerDioInterceptor());
    return this;
  }

  // Dio clone(String baseUrl) {
  //   final options = _getBaseOptions(baseUrl);
  //   var clonedDio = Dio(options);
  //   clonedDio.interceptors.addAll(interceptors);
  //   clonedDio.httpClientAdapter = httpClientAdapter;
  //   clonedDio.transformer = transformer;
  //   return clonedDio;
  // }
  //
  // Dio cloneWithCabinetBaseUrl() {
  //   return clone(Constants.baseUrlCabinet);
  // }
}

BaseOptions _getBaseOptions(String baseUrl) {
  return BaseOptions(baseUrl: baseUrl, headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
  });
}

PrettyDioLogger get _loggerInterceptor => PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    );

Interceptor get _headerInterceptor => InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) {
        options.headers.addAll(_basicAuthHeaders);
        handler.next(options);
      },
    );

Map<String, String> get _basicAuthHeaders {
  final headers = <String, String>{};

  return headers;
}
