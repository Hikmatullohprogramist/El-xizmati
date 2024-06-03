import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/datasource/network/interceptor/common_interceptor.dart';
import 'package:onlinebozor/data/datasource/network/interceptor/error_interceptor.dart';
import 'package:onlinebozor/data/datasource/network/interceptor/language_interceptor.dart';
import 'package:onlinebozor/data/datasource/network/services/ad_creation_service.dart';
import 'package:onlinebozor/data/datasource/network/services/ad_service.dart';
import 'package:onlinebozor/data/datasource/network/services/auth_service.dart';
import 'package:onlinebozor/data/datasource/network/services/card_service.dart';
import 'package:onlinebozor/data/datasource/network/services/cart_service.dart';
import 'package:onlinebozor/data/datasource/network/services/common_service.dart';
import 'package:onlinebozor/data/datasource/network/services/favorite_service.dart';
import 'package:onlinebozor/data/datasource/network/services/payment_service.dart';
import 'package:onlinebozor/data/datasource/network/services/report_service.dart';
import 'package:onlinebozor/data/datasource/network/services/user_ad_service.dart';
import 'package:onlinebozor/data/datasource/network/services/user_address_service.dart';
import 'package:onlinebozor/data/datasource/network/services/user_order_service.dart';
import 'package:onlinebozor/data/datasource/network/services/user_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String dio_default = "default_dio";

extension GetItModuleNetwork on GetIt {
  Future<void> networkModule() async {
    registerLazySingleton(() => CommonInterceptor(get()));
    registerLazySingleton(() => LanguageInterceptor(get()));
    registerLazySingleton(() => ErrorInterceptor());
    registerLazySingleton(() => ChuckerDioInterceptor());

    registerLazySingleton(
      () => InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers.addAll(<String, String>{});
          handler.next(options);
        },
      ),
    );
    registerLazySingleton(
      () => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    CommonInterceptor commonInterceptor = get();
    LanguageInterceptor languageInterceptor = get();
    ErrorInterceptor errorInterceptor = get();
    InterceptorsWrapper headerInterceptor = get();
    PrettyDioLogger loggerInterceptor = get();
    ChuckerDioInterceptor chuckerDioInterceptor = get();

    final interceptors = [
      commonInterceptor,
      languageInterceptor,
      loggerInterceptor,
      errorInterceptor,
      headerInterceptor,
      chuckerDioInterceptor
    ];

    registerSingleton<Dio>(
      provideDefaultDio(interceptors: interceptors),
      instanceName: dio_default,
    );

    registerLazySingleton(
        () => AdCreationService(get(instanceName: dio_default)));
    registerLazySingleton(() => AdService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => AuthService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => CardService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => CartService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => CommonService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => FavoriteService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => PaymentService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => ReportService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => UserAdService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => UserAddressService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => UserOrderService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(
        () => UserService(get<Dio>(instanceName: dio_default)));

    await allReady();
  }
}

Dio provideDefaultDio({List<Interceptor> interceptors = const []}) {
  final Dio dio = Dio();

  final timeout = Duration(seconds: 120);
  final options = BaseOptions(
    baseUrl: Constants.baseUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  dio.options = options
    ..connectTimeout = timeout
    ..receiveTimeout = timeout
    ..sendTimeout = timeout;

  dio.interceptors.addAll(interceptors);

  return dio;
}
