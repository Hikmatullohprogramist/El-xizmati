import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/datasource/floor/constants/floor_names.dart';
import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/database/app_database.dart';
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
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/card_repositroy.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/common_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/data/repositories/payment_repository.dart';
import 'package:onlinebozor/data/repositories/report_repository.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_ad_repository.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/data/repositories/user_order_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/presentation/di/get_it_injection.dart';
import 'package:onlinebozor/presentation/features/ad/ad_detail/ad_detail_cubit.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list/ad_list_cubit.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list_actions/ad_list_actions_cubit.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list_by_type/ad_list_by_type_cubit.dart';
import 'package:onlinebozor/presentation/features/ad/user_ad_detail/user_ad_detail_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/confirm/confirmation_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/confirmation/face_id_confirmation_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/start/face_id_start_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/login/login_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/one_id/one_id_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/set_password/set_password_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/start/auth_start_cubit.dart';
import 'package:onlinebozor/presentation/features/common/add_address/add_address_cubit.dart';
import 'package:onlinebozor/presentation/features/common/category_selection/category_selection_cubit.dart';
import 'package:onlinebozor/presentation/features/common/currency_selection/currency_selection_cubit.dart';
import 'package:onlinebozor/presentation/features/common/favorites/favorite_list_cubit.dart';
import 'package:onlinebozor/presentation/features/common/favorites/features/product/favorite_products_cubit.dart';
import 'package:onlinebozor/presentation/features/common/favorites/features/service/favorite_services_cubit.dart';
import 'package:onlinebozor/presentation/features/common/language/set_language_cubit.dart';
import 'package:onlinebozor/presentation/features/common/notification/notification_list_cubit.dart';
import 'package:onlinebozor/presentation/features/common/payment_type_selection/payment_type_selection_cubit.dart';
import 'package:onlinebozor/presentation/features/common/popular_categories/popular_categories_cubit.dart';
import 'package:onlinebozor/presentation/features/common/region_selection/region_selection_cubit.dart';
import 'package:onlinebozor/presentation/features/common/report/submit_report_cubit.dart';
import 'package:onlinebozor/presentation/features/common/search/search_cubit.dart';
import 'package:onlinebozor/presentation/features/common/unit_selection/unit_selection_cubit.dart';
import 'package:onlinebozor/presentation/features/common/user_warehouse_selection/user_warehouse_selection_cubit.dart';
import 'package:onlinebozor/presentation/features/creation/ad_creation_result/ad_creation_result_cubit.dart';
import 'package:onlinebozor/presentation/features/creation/order_creation/order_creation_cubit.dart';
import 'package:onlinebozor/presentation/features/creation/product_ad_creation/product_ad_creation_cubit.dart';
import 'package:onlinebozor/presentation/features/creation/request_ad_creation/request_ad_creation_cubit.dart';
import 'package:onlinebozor/presentation/features/creation/service_ad_creation/service_ad_creation_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/ad_creation_chooser/ad_creation_chooser_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/cart/cart_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/category/category_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/category/features/sub_category_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/dashboard/dashboard_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/payment_transactions/features/payment_transaction_filter/payment_transaction_filter_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/payment_transactions/payment_transactions_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_edit/profile_edit_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_view/profile_view_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/registration/registration_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_active_sessions/user_active_sessions_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_address/user_addresses_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_ads/features/ad_list/user_ad_list_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_ads/user_ads_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_cards/user_cards_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_cancel/user_order_cancel_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_info/user_order_info_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_list/user_order_list_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/user_orders_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/profile_cubit.dart';
import 'package:onlinebozor/presentation/features/home/home_cubit.dart';
import 'package:onlinebozor/presentation/features/realpay/add_card/add_card_with_realpay_cubit.dart';
import 'package:onlinebozor/presentation/features/realpay/refill/refill_with_realpay_cubit.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message_manager.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message_manager_impl.dart';
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

    registerLazySingleton(() => AdCreationService(get(instanceName: dio_default)));
    registerLazySingleton(() => AdService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => AuthService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => CardService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => CartService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => CommonService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => FavoriteService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => PaymentService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => ReportService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => UserAdService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => UserAddressService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => UserOrderService(get<Dio>(instanceName: dio_default)));
    registerLazySingleton(() => UserService(get<Dio>(instanceName: dio_default)));

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
