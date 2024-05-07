import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/datasource/network/intercepter/common_interceptor.dart';
import 'package:onlinebozor/data/datasource/network/intercepter/error_interceptor.dart';
import 'package:onlinebozor/data/datasource/network/intercepter/language_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio createDefaultDio(
    CommonInterceptor commonInterceptor,
    ErrorInterceptor errorInterceptor,
    LanguageInterceptor languageInterceptor,
  ) {
    final Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final loggerInterceptor = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    );

    final headerInterceptor = InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers.addAll(_basicAuthHeaders);
        handler.next(options);
      },
    );

    dio.interceptors.add(commonInterceptor);
    dio.interceptors.add(languageInterceptor);
    dio.interceptors.add(loggerInterceptor);
    dio.interceptors.add(errorInterceptor);
    dio.interceptors.add(headerInterceptor);
    dio.interceptors.add(ChuckerDioInterceptor());

    return dio;
  }

  Map<String, String> get _basicAuthHeaders {
    final headers = <String, String>{};

    return headers;
  }
}
