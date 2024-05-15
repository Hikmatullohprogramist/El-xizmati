import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/unit/unit_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/models/report/report_type.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/features/ad/ad_detail/ad_detail_page.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list/ad_list_page.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list_actions/ad_list_actions.dart';
import 'package:onlinebozor/presentation/features/ad/ad_list_by_type/ad_list_by_type_page.dart';
import 'package:onlinebozor/presentation/features/ad/user_ad_detail/user_ad_detail_page.dart';
import 'package:onlinebozor/presentation/features/auth/confirm/auth_confirm_page.dart';
import 'package:onlinebozor/presentation/features/auth/eds/auth_with_eds_page.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/face_id_validate_page.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/features/identity_verification/face_id_identity_page.dart';
import 'package:onlinebozor/presentation/features/auth/login/auth_login_page.dart';
import 'package:onlinebozor/presentation/features/auth/one_id/auth_with_one_id_page.dart';
import 'package:onlinebozor/presentation/features/auth/set_password/set_password_page.dart';
import 'package:onlinebozor/presentation/features/auth/start/auth_start_page.dart';
import 'package:onlinebozor/presentation/features/common/add_address/add_address_page.dart';
import 'package:onlinebozor/presentation/features/common/category_selection/category_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/currency_selection/currency_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/favorites/favorite_list_page.dart';
import 'package:onlinebozor/presentation/features/common/favorites/features/product/favorite_products_page.dart';
import 'package:onlinebozor/presentation/features/common/favorites/features/service/favorite_services_page.dart';
import 'package:onlinebozor/presentation/features/common/image_viewer/image_viewer_page.dart';
import 'package:onlinebozor/presentation/features/common/image_viewer/locale_image_viewer_page.dart';
import 'package:onlinebozor/presentation/features/common/intro/intro_page.dart';
import 'package:onlinebozor/presentation/features/common/language/change_language/change_language_page.dart';
import 'package:onlinebozor/presentation/features/common/language/set_language/set_language_page.dart';
import 'package:onlinebozor/presentation/features/common/nested_category_selection/nested_category_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/notification/notification_list_page.dart';
import 'package:onlinebozor/presentation/features/common/payment_type_selection/payment_type_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/popular_categories/popular_categories_page.dart';
import 'package:onlinebozor/presentation/features/common/region_and_district_selection/region_and_district_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/report/submit_report_page.dart';
import 'package:onlinebozor/presentation/features/common/search/search_page.dart';
import 'package:onlinebozor/presentation/features/common/unit_selection/unit_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/user_address_selection/user_address_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/user_warehouse_selection/user_warehouse_selection_page.dart';
import 'package:onlinebozor/presentation/features/creation/create_ad_result/create_ad_result_page.dart';
import 'package:onlinebozor/presentation/features/creation/create_ad_start/create_ad_start_page.dart';
import 'package:onlinebozor/presentation/features/creation/create_order/create_order_page.dart';
import 'package:onlinebozor/presentation/features/creation/create_product_ad/create_product_ad_page.dart';
import 'package:onlinebozor/presentation/features/creation/create_request_ad/create_request_ad_page.dart';
import 'package:onlinebozor/presentation/features/creation/create_request_start/create_request_start_page.dart';
import 'package:onlinebozor/presentation/features/creation/create_service_ad/create_service_ad_page.dart';
import 'package:onlinebozor/presentation/features/home/features/cart/cart_page.dart';
import 'package:onlinebozor/presentation/features/home/features/category/category_page.dart';
import 'package:onlinebozor/presentation/features/home/features/category/features/sub_category_page.dart';
import 'package:onlinebozor/presentation/features/home/features/create_ad_chooser/create_ad_chooser_page.dart';
import 'package:onlinebozor/presentation/features/home/features/dashboard/dashboard_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/chats/chats_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/chats/features/buying_chats/buying_chats_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/chats/features/chat/chat_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/chats/features/saved_chats/saved_chats_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/chats/features/selling_chats/selling_chats_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/comparison_detail/comparision_detail_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/payment_transaction/features/payment_transaction_filter/payment_transaction_filter_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/payment_transaction/payment_transaction_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_view/features/profile_edit/profile_edit_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_view/features/registration/registration_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/profile_view/profile_view_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/promotion/promotion_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/settings/features/notification_settings/notification_settings_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/settings/features/user_active_device/user_active_sessions_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/settings/features/user_social_network/user_social_accounts_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/settings/settings_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_address/user_addresses_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_ads/features/ad_list/user_ad_list_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_ads/user_ads_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_cards/features/add_card/add_card_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_cards/user_cards_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_order_type/user_order_type_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_cancel/user_order_cancel_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_info/user_order_info_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_list/use_order_list_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/user_orders_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/wallet_filling/page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/profile_page.dart';
import 'package:onlinebozor/presentation/features/home/home_page.dart';

import '../../domain/models/ad/ad_list_type.dart';
import '../../domain/models/ad/ad_transaction_type.dart';
import '../../domain/models/ad/ad_type.dart';
import '../../domain/models/ad/user_ad.dart';
import '../../domain/models/ad/user_ad_status.dart';
import '../../domain/models/district/district.dart';
import '../../domain/models/image/uploadable_file.dart';
import '../../domain/models/order/order_type.dart';
import '../../domain/models/order/user_order_status.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Intro
        AutoRoute(
          page: IntroRoute.page,
          path: "/intro",
          // initial: true,
        ),

        /// Language
        AutoRoute(
          page: SetLanguageRoute.page,
          path: "/set_language",
          initial: true,
        ),

        /// Add address
        AutoRoute(page: AddAddressRoute.page, path: '/add_address'),

        /// Auth
        AutoRoute(page: AuthStartRoute.page, path: "/auth_start"),
        AutoRoute(page: AuthConfirmRoute.page, path: '/auth_confirmation'),
        AutoRoute(page: AuthLoginRoute.page, path: '/auth_verification'),
        AutoRoute(page: SetPasswordRoute.page, path: '/set_password'),
        AutoRoute(page: AuthWithEdsRoute.page, path: '/eds'),
        AutoRoute(page: AuthWithOneIdRoute.page, path: "/login_with_one_id"),
        AutoRoute(page: FaceIdValidateRoute.page, path: "/face_id_validate"),
        AutoRoute(page: FaceIdIdentityRoute.page, path: "/face_id_identity"),

        /// home
        AutoRoute(page: HomeRoute.page),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: false,
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              path: 'dashboard',
              maintainState: true,
              keepHistory: false,
            ),
            AutoRoute(
              page: CategoryRoute.page,
              path: 'category',
              keepHistory: false,
            ),
            AutoRoute(
              page: CreateAdChooserRoute.page,
              path: 'create_ad_chooser',
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
              maintainState: false,
              keepHistory: false,
            ),
            AutoRoute(
              page: FavoriteServicesRoute.page,
              path: 'favorites_services',
              maintainState: false,
              keepHistory: false,
            )
          ],
        ),

        /// create product ad
        AutoRoute(
          page: CreateProductAdRoute.page,
          path: '/create_product_ad',
        ),

        /// create service ad
        AutoRoute(
          page: CreateServiceAdRoute.page,
          path: '/create_service_ad',
        ),

        /// create service ad
        AutoRoute(
          page: CreateAdResultRoute.page,
          path: '/create_ad_result',
        ),

        /// create request start
        AutoRoute(
          page: CreateRequestStartRoute.page,
          path: "/create_request_start",
        ),

        /// create request ad
        AutoRoute(
          page: CreateRequestAdRoute.page,
          path: "/create_request_ad",
        ),

        /// create service request
        AutoRoute(
          page: UserOrderTypeRoute.page,
          path: '/user_order_type',
        ),

        ///  sub category
        AutoRoute(page: SubCategoryRoute.page, path: "/sub_category"),

        /// order create
        AutoRoute(page: CreateOrderRoute.page, path: '/create_order'),

        /// Ads collections
        AutoRoute(
          page: AdListByTypeRoute.page,
          path: "/ads_list_by_type",
        ),
        AutoRoute(
          page: AdListRoute.page,
          path: '/ads_list',
          maintainState: false,
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
        AutoRoute(page: SearchRoute.page, path: '/search'),
        AutoRoute(page: NotificationListRoute.page, path: '/notification_list'),

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

        //   profile page
        AutoRoute(page: WalletFillingRoute.page, path: '/wallet_filling'),
        AutoRoute(page: ProfileViewRoute.page, path: '/profile_viewer'),
        AutoRoute(page: UserAddressesRoute.page, path: '/my_addresses'),

        /// user ads
        AutoRoute(
          page: UserAdsRoute.page,
          path: '/user_ads',
          children: [
            AutoRoute(page: UserAdListRoute.page, path: "user_ad_list"),
          ],
        ),

        /// ad list actions
        AutoRoute(page: AdListActionsRoute.page, path: '/ad_list_actions'),

        AutoRoute(page: UserCardsRoute.page, path: '/user_card_list'),

        /// user orders
        AutoRoute(page: AddCardRoute.page, path: '/add_card'),
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

        /// user chat lists
        AutoRoute(
          page: ChatsRoute.page,
          path: '/chats',
          children: [
            AutoRoute(page: SellingChatsRoute.page, path: 'selling'),
            AutoRoute(page: BuyingChatsRoute.page, path: 'buying'),
            AutoRoute(page: SavedChatsRoute.page, path: 'saved')
          ],
        ),

        /// Chat
        AutoRoute(
          page: ChatRoute.page,
          path: '/chat',
        ),

        /// Payment transactions
        AutoRoute(
          page: PaymentTransactionRoute.page,
          path: '/payment_transaction',
        ),
        AutoRoute(
          page: PaymentTransactionFilterRoute.page,
          path: '/payment_transaction_filter',
        ),

        AutoRoute(page: ProfileEditRoute.page, path: '/profile_edit'),
        AutoRoute(page: RegistrationRoute.page, path: '/identified'),
        AutoRoute(page: ComparisonDetailRoute.page, path: '/comparison_detail'),
        AutoRoute(page: PromotionRoute.page, path: '/promotion'),
        AutoRoute(page: SettingRoute.page, path: '/setting'),

        AutoRoute(
          page: UserActiveSessionsRoute.page,
          path: '/user_active_sessions',
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
          page: UserSocialAccountsRoute.page,
          path: '/user_social_accounts',
        ),
        AutoRoute(
          page: NotificationSettingsRoute.page,
          path: '/notification_settings',
        ),
        AutoRoute(page: UserAdDetailRoute.page, path: "/user_ad_detail"),
        AutoRoute(page: ChangeLanguageRoute.page, path: '/change_language'),

        AutoRoute(
          page: NestedCategorySelectionRoute.page,
          path: '/nested_category_selection',
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
          page: UserActiveSessionsRoute.page,
          path: '/user_address_selection',
        ),

        AutoRoute(
          page: RegionAndDistrictSelectionRoute.page,
          path: '/region_and_district_selection',
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
