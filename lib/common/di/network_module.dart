import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/domain/model/auth_interceptor/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {

  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) {
    final options = BaseOptions(baseUrl: Constants.baseUrl);
    final dio = Dio(options);
    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(_loggerInterceptor);
    dio.interceptors.add(_headerInterceptor);
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
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) {
          options.headers.addAll(_basicAuthHeaders);
          handler.next(options);
        },
      );

  Map<String, String> get _basicAuthHeaders {
    String username = ',DLT)7\'q]Zb|Mx0+';
    String password = '!T4P3a9}Rx\'eXo^[~2bhLkIB"Mo\$=(LG';
    final encoded = base64.encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encoded';

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'mobile': 'true',
      'authorization': basicAuth,
      'entity': 'OnlineBozor'
    };

    return headers;
  }
}
