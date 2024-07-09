import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/unit/unit_response.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/domain/models/otp/otp_confirm_type.dart';
import 'package:onlinebozor/domain/models/report/report_type.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/features/ad/ad_detail/ad_detail_page.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list/ad_list_page.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list_by_type/ad_list_by_type_page.dart';
import 'package:onlinebozor/presentation/features/ad/user_ad_detail/user_ad_detail_page.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/confirmation/face_id_confirmation_page.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/start/face_id_start_page.dart';
import 'package:onlinebozor/presentation/features/auth/login/login_page.dart';
import 'package:onlinebozor/presentation/features/auth/one_id/one_id_page.dart';
import 'package:onlinebozor/presentation/features/auth/otp_confirm/otp_confirmation_page.dart';
import 'package:onlinebozor/presentation/features/auth/registration/registration_page.dart';
import 'package:onlinebozor/presentation/features/auth/reset_password/reset_password_page.dart';
import 'package:onlinebozor/presentation/features/auth/start/auth_start_page.dart';
import 'package:onlinebozor/presentation/features/common/add_address/add_address_page.dart';
import 'package:onlinebozor/presentation/features/common/category_selection/category_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/currency_selection/currency_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/favorites/favorite_list_page.dart';
import 'package:onlinebozor/presentation/features/common/favorites/features/product/favorite_products_page.dart';
import 'package:onlinebozor/presentation/features/common/favorites/features/service/favorite_services_page.dart';
import 'package:onlinebozor/presentation/features/common/image_viewer/image_viewer_page.dart';
import 'package:onlinebozor/presentation/features/common/image_viewer/locale_image_viewer_page.dart';
import 'package:onlinebozor/presentation/features/common/language/set_language_page.dart';
import 'package:onlinebozor/presentation/features/common/notification/notification_list_page.dart';
import 'package:onlinebozor/presentation/features/common/payment_type_selection/payment_type_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/popular_categories/popular_categories_page.dart';
import 'package:onlinebozor/presentation/features/common/region_selection/region_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/report/submit_report_page.dart';
import 'package:onlinebozor/presentation/features/common/search/search_page.dart';
import 'package:onlinebozor/presentation/features/common/unit_selection/unit_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/user_address_selection/user_address_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/user_warehouse_selection/user_warehouse_selection_page.dart';
import 'package:onlinebozor/presentation/features/creation/ad_creation_result/ad_creation_result_page.dart';
import 'package:onlinebozor/presentation/features/creation/order_creation/order_creation_page.dart';
import 'package:onlinebozor/presentation/features/creation/product_ad_creation/product_ad_creation_page.dart';
import 'package:onlinebozor/presentation/features/creation/request_ad_creation/request_ad_creation_page.dart';
import 'package:onlinebozor/presentation/features/creation/service_ad_creation/service_ad_creation_page.dart';
import 'package:onlinebozor/presentation/features/home/features/ad_creation_chooser/ad_creation_chooser_page.dart';
import 'package:onlinebozor/presentation/features/home/features/cart/cart_page.dart';
import 'package:onlinebozor/presentation/features/home/features/category/category_page.dart';
import 'package:onlinebozor/presentation/features/home/features/category/features/sub_category_page.dart';
import 'package:onlinebozor/presentation/features/home/features/dashboard/dashboard_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/billing_transactions/billing_transactions_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/billing_transactions/features/filter/billing_transaction_filter_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/identity_verification/identity_verification_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_edit/profile_edit_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_view/profile_view_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_active_sessions/user_active_sessions_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_address/user_addresses_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_ads/features/ad_list/user_ad_list_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_ads/user_ads_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_cards/user_cards_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_cancel/user_order_cancel_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_info/user_order_info_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_list/user_order_list_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/user_orders_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/profile_page.dart';
import 'package:onlinebozor/presentation/features/home/home_page.dart';
import 'package:onlinebozor/presentation/features/realpay/add_card/add_card_with_realpay_page.dart';
import 'package:onlinebozor/presentation/features/realpay/refill/refill_with_realpay_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Language
        AutoRoute(
          page: SetLanguageRoute.page,
          path: "/set_language",
          initial: false,
        ),

        /// Add address
        AutoRoute(
          page: AddAddressRoute.page,
          path: '/add_address',
        ),

        /// Auth
        AutoRoute(
          page: AuthStartRoute.page,
          path: "/auth_start",
        ),
        AutoRoute(
          page: OtpConfirmationRoute.page,
          path: '/confirmation',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: ResetPasswordRoute.page,
          path: '/reset_password',
        ),
        AutoRoute(
          page: RegistrationRoute.page,
          path: '/registration',
        ),
        AutoRoute(
          page: OneIdRoute.page,
          path: "/one_id",
        ),
        AutoRoute(
          page: FaceIdStartRoute.page,
          path: "/face_id_start",
        ),
        AutoRoute(
          page: FaceIdConfirmationRoute.page,
          path: "/face_id_confirmation",
        ),

        /// home
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: true,
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              path: 'dashboard',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: CategoryRoute.page,
              path: 'category',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: AdCreationChooserRoute.page,
              path: 'create_ad_chooser',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: CartRoute.page,
              path: 'cart',
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: ProfileRoute.page,
              path: 'profile',
              maintainState: false,
              keepHistory: false,
            )
          ],
        ),

        /// Favorite ads
        AutoRoute(
          page: FavoriteListRoute.page,
          path: '/favorite_list',
          maintainState: true,
          children: [
            AutoRoute(
              page: FavoriteProductsRoute.page,
              path: 'favorites_products',
              maintainState: true,
              keepHistory: false,
            ),
            AutoRoute(
              page: FavoriteServicesRoute.page,
              path: 'favorites_services',
              maintainState: true,
              keepHistory: false,
            )
          ],
        ),

        /// create product ad
        AutoRoute(
          page: ProductAdCreationRoute.page,
          path: '/product_ad_creation',
        ),

        /// create service ad
        AutoRoute(
          page: ServiceAdCreationRoute.page,
          path: '/service_ad_creation',
        ),

        /// create service ad
        AutoRoute(
          page: AdCreationResultRoute.page,
          path: '/ad_creation_result',
        ),

        /// create request ad
        AutoRoute(
          page: RequestAdCreationRoute.page,
          path: "/request_ad_creation",
        ),

        ///  sub category
        AutoRoute(page: SubCategoryRoute.page, path: "/sub_category"),

        /// order create
        AutoRoute(
          page: OrderCreationRoute.page,
          path: '/order_creation',
        ),

        /// Ads collections
        AutoRoute(
          page: AdListByTypeRoute.page,
          path: "/ads_list_by_type",
        ),
        AutoRoute(
          page: AdListRoute.page,
          path: '/ads_list',
        ),
        AutoRoute(
          page: AdDetailRoute.page,
          path: '/ads_detail',
        ),

        //  common page
        AutoRoute(
          page: PopularCategoriesRoute.page,
          path: '/popular_categories',
        ),
        AutoRoute(
          page: SearchRoute.page,
          path: '/search',
        ),
        AutoRoute(
          page: NotificationListRoute.page,
          path: '/notification_list',
        ),
        AutoRoute(
          page: UserActiveSessionsRoute.page,
          path: '/user_active_sessions',
        ),

        /// image viewer
        AutoRoute(
          page: ImageViewerRoute.page,
          path: '/image_viewer',
        ),

        /// local image viewer
        AutoRoute(
          page: LocaleImageViewerRoute.page,
          path: '/local_image_viewer',
        ),

        ///   profile page
        AutoRoute(
          page: ProfileViewRoute.page,
          path: '/profile_viewer',
        ),
        AutoRoute(
          page: UserAddressesRoute.page,
          path: '/user_addresses',
        ),
        AutoRoute(
          page: UserAdsRoute.page,
          path: '/user_ads',
          children: [
            AutoRoute(page: UserAdListRoute.page, path: "user_ad_list"),
          ],
        ),
        AutoRoute(
          page: UserCardsRoute.page,
          path: '/user_card_list',
        ),
        AutoRoute(
          page: UserOrdersRoute.page,
          path: '/user_orders',
          children: [
            AutoRoute(
              page: UserOrderListRoute.page,
              path: 'user_order_list',
            ),
          ],
        ),

        /// RealPay Payment
        AutoRoute(
          page: RefillWithRealPayRoute.page,
          path: '/refill_with_realpay',
        ),

        /// RealPay Payment
        AutoRoute(
          page: AddCardWithRealPayRoute.page,
          path: '/add_card_with_realpay',
        ),

        /// Payment transactions
        AutoRoute(
          page: BillingTransactionsRoute.page,
          path: '/billing_transactions',
        ),
        AutoRoute(
          page: BillingTransactionFilterRoute.page,
          path: '/billing_transaction_filter',
        ),

        AutoRoute(
          page: ProfileEditRoute.page,
          path: '/profile_edit',
        ),
        AutoRoute(
          page: IdentityVerificationRoute.page,
          path: '/identity_verification',
        ),
        AutoRoute(
          page: UserOrderCancelRoute.page,
          path: '/user_order_cancel',
        ),
        AutoRoute(
          page: UserOrderInfoRoute.page,
          path: '/user_order_info',
        ),
        AutoRoute(
          page: UserAdDetailRoute.page,
          path: "/user_ad_detail",
        ),

        AutoRoute(
          page: CategorySelectionRoute.page,
          path: '/category_selection',
        ),

        AutoRoute(
          page: PaymentTypeSelectionRoute.page,
          path: '/payment_type_selection',
        ),

        AutoRoute(
          page: RegionSelectionRoute.page,
          path: '/region_selection',
        ),

        AutoRoute(
          page: UserWarehouseSelectionRoute.page,
          path: '/user_warehouse_selection',
        ),

        AutoRoute(
          page: UnitSelectionRoute.page,
          path: '/unit_selection',
        ),

        AutoRoute(
          page: SubmitReportRoute.page,
          path: '/submit_report',
        ),
      ];
}
