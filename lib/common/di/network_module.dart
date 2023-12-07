import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../intercepter/intercepter/app_intercepter.dart';
import '../intercepter/intercepter/language_intercepter.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(
      LanguageInterceptor languageInterceptor, AppInterceptor appInterceptor) {
    final options = BaseOptions(baseUrl: Constants.baseUrl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final dio = Dio(options);
    dio.interceptors.add(languageInterceptor);
    dio.interceptors.add(appInterceptor);
    dio.interceptors.add(_loggerInterceptor);
    dio.interceptors.add(_headerInterceptor);
    dio.interceptors.add(ChuckerDioInterceptor());
    return dio;
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
    onRequest: (RequestOptions options,
        RequestInterceptorHandler handler,) {
      options.headers.addAll(_basicAuthHeaders);
      handler.next(options);
    },
  );

  Map<String, String> get _basicAuthHeaders {
    final headers = <String, String>{};

    return headers;
  }
}