import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
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

extension GetItModuleApp on GetIt {
  Future<void> appModule() async {
    registerLazySingleton(() => Logger());

    registerSingleton<StateMessageManager>(StateMessageManagerImpl());

    // ad
    registerFactory(() => AdDetailCubit(get(), get(), get(), get()));
    registerFactory<AdListCubit>(() => AdListCubit(get(), get(), get()));
    registerFactory<AdListActionsCubit>(() => AdListActionsCubit());
    registerFactory<AdListByTypeCubit>(() => AdListByTypeCubit(get(), get()));
    registerFactory<UserAdDetailCubit>(() => UserAdDetailCubit(get()));

    // auth
    registerFactory<ConfirmationCubit>(() => ConfirmationCubit(get(), get()));
    registerFactory<FaceIdConfirmationCubit>(
      () => FaceIdConfirmationCubit(get(), get()),
    );
    registerFactory<FaceIdStartCubit>(() => FaceIdStartCubit(get()));
    registerFactory<LoginCubit>(() => LoginCubit(get(), get()));
    registerFactory<OneIdCubit>(() => OneIdCubit(get(), get()));
    registerFactory<SetPasswordCubit>(() => SetPasswordCubit(get()));
    registerFactory(() => AuthStartCubit(get()));

    // common
    registerFactory<AddAddressCubit>(() => AddAddressCubit(get(), get()));
    registerFactory<CategorySelectionCubit>(
        () => CategorySelectionCubit(get()));
    registerFactory<CurrencySelectionCubit>(
        () => CurrencySelectionCubit(get()));
    registerFactory<FavoriteListCubit>(() => FavoriteListCubit());
    registerFactory<FavoriteProductsCubit>(() => FavoriteProductsCubit(get()));
    registerFactory<FavoriteServicesCubit>(() => FavoriteServicesCubit(get()));
    registerFactory<SetLanguageCubit>(() => SetLanguageCubit(get()));
    registerFactory<NotificationListCubit>(() => NotificationListCubit());
    registerFactory<PaymentTypeSelectionCubit>(
        () => PaymentTypeSelectionCubit(get()));
    registerFactory<PopularCategoriesCubit>(
        () => PopularCategoriesCubit(get()));
    registerFactory<RegionSelectionCubit>(() => RegionSelectionCubit(get()));
    registerFactory<SubmitReportCubit>(() => SubmitReportCubit(get()));
    registerFactory<SearchCubit>(() => SearchCubit(get()));
    registerFactory<UnitSelectionCubit>(() => UnitSelectionCubit(get()));
    registerFactory<UserWarehouseSelectionCubit>(
        () => UserWarehouseSelectionCubit(get()));

    // creation
    registerFactory<AdCreationResultCubit>(() => AdCreationResultCubit());
    registerFactory<OrderCreationCubit>(
        () => OrderCreationCubit(get(), get(), get(), get(), get(), get()));
    registerFactory<ProductAdCreationCubit>(
        () => ProductAdCreationCubit(get(), get(), get()));
    registerFactory<RequestAdCreationCubit>(
        () => RequestAdCreationCubit(get(), get(), get()));
    registerFactory<ServiceAdCreationCubit>(
        () => ServiceAdCreationCubit(get(), get(), get()));

    // home
    registerFactory(() => HomeCubit());
    registerFactory(() => CartCubit(get(), get()));
    registerFactory(() => CategoryCubit(get()));
    registerFactory(() => SubCategoryCubit());
    registerFactory(() => AdCreationChooserCubit(get()));
    registerFactory(() => DashboardCubit(get(), get(), get(), get()));
    registerFactory(() => ProfileCubit(get(), get()));

    // profile
    registerFactory<PaymentTransactionsCubit>(
        () => PaymentTransactionsCubit(get()));
    registerFactory<PaymentTransactionFilterCubit>(
        () => PaymentTransactionFilterCubit(get()));
    registerFactory<ProfileEditCubit>(() => ProfileEditCubit(get()));
    registerFactory<ProfileViewCubit>(() => ProfileViewCubit(get(), get()));
    registerFactory<RegistrationCubit>(() => RegistrationCubit(get()));
    registerFactory<UserActiveSessionsCubit>(
        () => UserActiveSessionsCubit(get()));
    registerFactory<UserAddressesCubit>(() => UserAddressesCubit(get()));
    registerFactory<UserAdsCubit>(() => UserAdsCubit());
    registerFactory<UserAdListCubit>(() => UserAdListCubit(get()));
    registerFactory<UserCardsCubit>(() => UserCardsCubit(get(), get()));
    registerFactory<UserOrdersCubit>(() => UserOrdersCubit());
    registerFactory<UserOrderCancelCubit>(() => UserOrderCancelCubit(get()));
    registerFactory<UserOrderInfoCubit>(() => UserOrderInfoCubit());
    registerFactory<UserOrderListCubit>(() => UserOrderListCubit(get()));

    // realpay
    registerFactory<AddCardWithRealpayCubit>(
        () => AddCardWithRealpayCubit(get()));
    registerFactory<RefillWithRealpayCubit>(
        () => RefillWithRealpayCubit(get()));

    await allReady();
  }
}
