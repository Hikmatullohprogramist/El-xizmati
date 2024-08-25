import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:El_xizmati/data/datasource/network/constants/constants.dart';
import 'package:El_xizmati/data/datasource/network/interceptor/auth_interceptor.dart';
import 'package:El_xizmati/data/datasource/network/interceptor/common_interceptor.dart';
import 'package:El_xizmati/data/datasource/network/interceptor/error_interceptor.dart';
import 'package:El_xizmati/data/datasource/network/interceptor/language_interceptor.dart';
import 'package:El_xizmati/data/datasource/network/interceptor/region_interceptor.dart';
import 'package:El_xizmati/data/datasource/network/services/private/ad_creation_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/ad_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/auth_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/card_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/cart_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/eds_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/favorite_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/identity_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/notification_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/payment_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/region_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_ad_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_address_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_order_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_service.dart';
import 'package:El_xizmati/data/datasource/network/services/public/ad_detail_service.dart';
import 'package:El_xizmati/data/datasource/network/services/public/ad_list_service.dart';
import 'package:El_xizmati/data/datasource/network/services/public/dashboard_service.dart';
import 'package:El_xizmati/data/datasource/network/services/public/report_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String private = "dio_with_authorization";
const String public = "dio_without_authorization";

extension GetItModuleNetwork on GetIt {
  Future<void> networkModule() async {
    registerLazySingleton(
      () => AuthInterceptor(get(), get(), get(), get(), get()),
    );
    registerLazySingleton(() => CommonInterceptor());
    registerLazySingleton(() => LanguageInterceptor(get()));
    registerLazySingleton(() => ErrorInterceptor());
    registerLazySingleton(() => RegionInterceptor(get()));
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

    AuthInterceptor authInterceptor = get();
    CommonInterceptor commonInterceptor = get();
    LanguageInterceptor languageInterceptor = get();
    RegionInterceptor regionInterceptor = get();
    ErrorInterceptor errorInterceptor = get();
    InterceptorsWrapper headerInterceptor = get();
    PrettyDioLogger loggerInterceptor = get();
    ChuckerDioInterceptor chuckerDioInterceptor = get();

    ///
    /// Providing public dio and services
    ///

    registerSingleton<Dio>(
      provideDio(
        interceptors: [
          commonInterceptor,
          languageInterceptor,
          regionInterceptor,
          loggerInterceptor,
          errorInterceptor,
          headerInterceptor,
          chuckerDioInterceptor
        ],
      ),
      instanceName: public,
    );

    registerLazySingleton(() => AdListService(get(instanceName: public)));
    registerLazySingleton(() => AdDetailService(get(instanceName: public)));

    registerLazySingleton(() => DashboardService(get(instanceName: public)));

    registerLazySingleton(() => ReportService(get(instanceName: public)));

    ///
    /// Providing private dio and services
    ///

    registerSingleton<Dio>(
      provideDio(
        interceptors: [
          authInterceptor,
          commonInterceptor,
          languageInterceptor,
          loggerInterceptor,
          chuckerDioInterceptor,
          errorInterceptor,
          headerInterceptor,
        ],
      ),
      instanceName: private,
    );

    registerLazySingleton(() => AdCreationService(get(instanceName: private)));
    registerLazySingleton(() => AdService(get(instanceName: private)));
    registerLazySingleton(() => AuthService(get(instanceName: private)));

    registerLazySingleton(() => CardService(get(instanceName: private)));
    registerLazySingleton(() => CartService(get(instanceName: private)));

    registerLazySingleton(() => EdsService(get(instanceName: private)));

    registerLazySingleton(() => FavoriteService(get(instanceName: private)));

    registerLazySingleton(() => IdentityService(get(instanceName: private)));

    registerLazySingleton(
        () => NotificationService(get(instanceName: private)));

    registerLazySingleton(() => PaymentService(get(instanceName: private)));

    registerLazySingleton(() => RegionService(get(instanceName: private)));

    registerLazySingleton(() => UserAdService(get(instanceName: private)));
    registerLazySingleton(() => UserAddressService(get(instanceName: private)));
    registerLazySingleton(() => UserOrderService(get(instanceName: private)));
    registerLazySingleton(() => UserService(get(instanceName: private)));

    await allReady();
  }
}

Dio provideDio({List<Interceptor> interceptors = const []}) {
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
