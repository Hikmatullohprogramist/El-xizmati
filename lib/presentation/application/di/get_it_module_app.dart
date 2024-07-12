import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/presentation/features/ad/ad_detail/ad_detail_cubit.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list/ad_list_cubit.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list_by_type/ad_list_by_type_cubit.dart';
import 'package:onlinebozor/presentation/features/ad/user_ad_detail/user_ad_detail_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/confirmation/face_id_confirmation_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/start/face_id_start_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/login/login_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/one_id/one_id_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/otp_confirm/otp_confirmation_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/registration/registration_cubit.dart';
import 'package:onlinebozor/presentation/features/auth/reset_password/reset_password_cubit.dart';
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
import 'package:onlinebozor/presentation/features/common/user_address_selection/user_address_selection_cubit.dart';
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
import 'package:onlinebozor/presentation/features/home/features/profile/features/billing_transactions/billing_transactions_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/billing_transactions/features/filter/billing_transaction_filter_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/identity_verification/identity_verification_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_edit/profile_edit_cubit.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_view/profile_view_cubit.dart';
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
    registerFactory(() => AdDetailCubit(get(), get(), get()));
    registerFactory(() => AdListCubit(get(), get(), get()));
    registerFactory(() => AdListByTypeCubit(get(), get()));
    registerFactory(() => UserAdDetailCubit(get()));

    // auth
    registerFactory(() => OtpConfirmationCubit(get()));
    registerFactory(() => FaceIdConfirmationCubit(get()));
    registerFactory(() => FaceIdStartCubit(get()));
    registerFactory(() => LoginCubit(get(), get()));
    registerFactory(() => OneIdCubit(get(), get()));
    registerFactory(() => ResetPasswordCubit(get()));
    registerFactory(() => AuthStartCubit(get(), get()));
    registerFactory(() => RegistrationCubit(get()));

    // common
    registerFactory(() => AddAddressCubit(get(), get()));
    registerFactory(() => CategorySelectionCubit(get()));
    registerFactory(() => CurrencySelectionCubit(get()));
    registerFactory(() => FavoriteListCubit());
    registerFactory(() => FavoriteProductsCubit(get()));
    registerFactory(() => FavoriteServicesCubit(get()));
    registerFactory(() => SetLanguageCubit(get()));
    registerFactory(() => NotificationListCubit(get()));
    registerFactory(() => PaymentTypeSelectionCubit(get()));
    registerFactory(() => PopularCategoriesCubit(get()));
    registerFactory(() => RegionSelectionCubit(get()));
    registerFactory(() => SubmitReportCubit(get()));
    registerFactory(() => SearchCubit(get()));
    registerFactory(() => UnitSelectionCubit(get()));
    registerFactory(() => UserAddressSelectionCubit(get()));
    registerFactory(() => UserWarehouseSelectionCubit(get()));

    // creation
    registerFactory(() => AdCreationResultCubit());
    registerFactory(
      () => OrderCreationCubit(get(), get(), get(), get(), get(), get()),
    );
    registerFactory(() => ProductAdCreationCubit(get(), get(), get()));
    registerFactory(() => RequestAdCreationCubit(get(), get(), get()));
    registerFactory(() => ServiceAdCreationCubit(get(), get(), get()));

    // home
    registerFactory(() => HomeCubit(get()));
    registerFactory(() => CartCubit(get(), get()));
    registerFactory(() => CategoryCubit(get()));
    registerFactory(() => SubCategoryCubit());
    registerFactory(() => AdCreationChooserCubit(get()));
    registerFactory(() => DashboardCubit(get(), get(), get(), get()));
    registerFactory(() => ProfileCubit(get(), get(), get(), get()));

    // profile
    registerFactory(() => BillingTransactionsCubit(get()));
    registerFactory(() => BillingTransactionFilterCubit(get()));
    registerFactory(() => IdentityVerificationCubit(get(), get(), get()));
    registerFactory(() => ProfileEditCubit(get(), get()));
    registerFactory(() => ProfileViewCubit(get(), get(), get()));
    registerFactory(() => UserActiveSessionsCubit(get()));
    registerFactory(() => UserAddressesCubit(get()));
    registerFactory(() => UserAdsCubit());
    registerFactory(() => UserAdListCubit(get()));
    registerFactory(() => UserCardsCubit(get(), get()));
    registerFactory(() => UserOrdersCubit());
    registerFactory(() => UserOrderCancelCubit(get()));
    registerFactory(() => UserOrderInfoCubit());
    registerFactory(() => UserOrderListCubit(get()));

    // realpay
    registerFactory(() => AddCardWithRealpayCubit(get()));
    registerFactory(() => RefillWithRealpayCubit(get()));

    await allReady();
  }
}
