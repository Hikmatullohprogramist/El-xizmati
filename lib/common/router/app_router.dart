import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebozor/presentation/common/language/change_language/change_language_page.dart';
import 'package:onlinebozor/presentation/creation/create_product_order/create_product_order_page.dart';
import 'package:onlinebozor/presentation/creation/create_service_order/create_service_order_page.dart';
import 'package:onlinebozor/presentation/home/home_page.dart';

import '../../data/responses/address/user_address_response.dart';
import '../../data/responses/category/category/category_response.dart';
import '../../data/responses/currencies/currency_response.dart';
import '../../data/responses/payment_type/payment_type_response.dart';
import '../../data/responses/region/region_root_response.dart';
import '../../data/responses/unit/unit_response.dart';
import '../../data/responses/user_ad/user_ad_response.dart';
import '../../domain/models/ad/ad_list_type.dart';
import '../../domain/models/ad/ad_type.dart';
import '../../domain/models/ad/user_ad_status.dart';
import '../../domain/models/district/district.dart';
import '../../domain/models/order/order_type.dart';
import '../../domain/models/order/user_order_status.dart';
import '../../presentation/ad/ad_detail/ad_detail_page.dart';
import '../../presentation/ad/ad_list/ad_list_page.dart';
import '../../presentation/ad/ad_list_actions/ad_list_actions.dart';
import '../../presentation/ad/ad_list_by_type/ad_list_by_type.dart';
import '../../presentation/ad/user_ad_detail/user_ad_detail.dart';
import '../../presentation/auth/confirm/auth_confirm_page.dart';
import '../../presentation/auth/eds/auth_with_eds_page.dart';
import '../../presentation/auth/one_id/auth_with_one_id_page.dart';
import '../../presentation/auth/set_password/set_password_page.dart';
import '../../presentation/auth/start/auth_start_page.dart';
import '../../presentation/auth/verification/auth_verification_page.dart';
import '../../presentation/common/favorites/favorite_list_page.dart';
import '../../presentation/common/favorites/features/product/favorite_products_page.dart';
import '../../presentation/common/favorites/features/service/favorite_services_page.dart';
import '../../presentation/common/image_viewer/image_viewer_page.dart';
import '../../presentation/common/image_viewer/locale_image_viewer_page.dart';
import '../../presentation/common/language/set_language/set_language_page.dart';
import '../../presentation/common/notification/notification_list_page.dart';
import '../../presentation/common/popular_categories/popular_categories_page.dart';
import '../../presentation/common/search/search_page.dart';
import '../../presentation/common/selection_category/selection_category_page.dart';
import '../../presentation/common/selection_currency/selection_currency_page.dart';
import '../../presentation/common/selection_nested_category/selection_nested_category_page.dart';
import '../../presentation/common/selection_payment_type/selection_payment_type_page.dart';
import '../../presentation/common/selection_region_and_district/selection_region_and_district_page.dart';
import '../../presentation/common/selection_unit/selection_unit_page.dart';
import '../../presentation/common/selection_user_address/selection_user_address_page.dart';
import '../../presentation/common/selection_user_warehouse/selection_user_warehouse_page.dart';
import '../../presentation/creation/create_ad_start/create_ad_start_page.dart';
import '../../presentation/creation/create_order_start/create_order_start_page.dart';
import '../../presentation/creation/create_product_ad/create_product_ad_page.dart';
import '../../presentation/creation/create_service_ad/create_service_ad_page.dart';
import '../../presentation/home/features/cart/cart_page.dart';
import '../../presentation/home/features/cart/features/order_create/order_create_page.dart';
import '../../presentation/home/features/category/category_page.dart';
import '../../presentation/home/features/category/features/sub_category_page.dart';
import '../../presentation/home/features/create_ad_chooser/create_ad_chooser_page.dart';
import '../../presentation/home/features/dashboard/dashboard_page.dart';
import '../../presentation/home/features/profile/features/chat_list/chat_list_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/buying_chats/buying_chats_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/chat/chat_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/saved_chats/saved_chats_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/selling_chats/selling_chats_page.dart';
import '../../presentation/home/features/profile/features/comparison_detail/comparision_detail_page.dart';
import '../../presentation/home/features/profile/features/payment_transaction/features/payment_transaction_filter/payment_transaction_filter_page.dart';
import '../../presentation/home/features/profile/features/payment_transaction/payment_transaction_page.dart';
import '../../presentation/home/features/profile/features/profile_view/features/profile_edit/profile_edit_page.dart';
import '../../presentation/home/features/profile/features/profile_view/features/registration/registration_page.dart';
import '../../presentation/home/features/profile/features/profile_view/profile_view_page.dart';
import '../../presentation/home/features/profile/features/promotion/promotion_page.dart';
import '../../presentation/home/features/profile/features/settings/features/notification_settings/notification_settings_page.dart';
import '../../presentation/home/features/profile/features/settings/features/user_active_device/user_action_sessions_page.dart';
import '../../presentation/home/features/profile/features/settings/features/user_social_network/user_social_accounts_page.dart';
import '../../presentation/home/features/profile/features/settings/settings_page.dart';
import '../../presentation/home/features/profile/features/user_address/features/add_address/add_address_page.dart';
import '../../presentation/home/features/profile/features/user_address/user_addresses_page.dart';
import '../../presentation/home/features/profile/features/user_ads/features/ad_list/user_ads_page.dart';
import '../../presentation/home/features/profile/features/user_ads/user_ad_list_page.dart';
import '../../presentation/home/features/profile/features/user_cards/features/add_card/add_card_page.dart';
import '../../presentation/home/features/profile/features/user_cards/user_card_list_page.dart';
import '../../presentation/home/features/profile/features/user_order_type/user_order_type_page.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_order_list/use_orders_page.dart';
import '../../presentation/home/features/profile/features/user_orders/user_order_list_page.dart';
import '../../presentation/home/features/profile/features/wallet_filling/page.dart';
import '../../presentation/home/features/profile/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// Language
        AutoRoute(
          page: SetLanguageRoute.page,
          path: "/set_language",
          initial: true,
        ),

        /// Auth
        AutoRoute(page: AuthStartRoute.page, path: "/auth_start"),
        AutoRoute(page: AuthConfirmRoute.page, path: '/auth_confirmation'),
        AutoRoute(page: AuthVerificationRoute.page, path: '/auth_verification'),
        AutoRoute(page: SetPasswordRoute.page, path: '/set_password'),
        AutoRoute(page: AuthWithEdsRoute.page, path: '/eds'),
        AutoRoute(page: AuthWithOneIdRoute.page, path: "/login_with_one_id"),

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
              maintainState: false,
            ),
            AutoRoute(page: CategoryRoute.page, path: 'category'),
            AutoRoute(
              page: CreateAdChooserRoute.page,
              path: 'create_ad_chooser',
            ),
            AutoRoute(page: CartRoute.page, path: 'cart', maintainState: false),
            AutoRoute(page: ProfileRoute.page, path: 'profile')
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
            ),
            AutoRoute(
              page: FavoriteServicesRoute.page,
              path: 'favorites_services',
              maintainState: false,
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

        /// create request start
        AutoRoute(
          page: CreateOrderStartRoute.page,
          path: "/create_request_start",
        ),

        /// create product request
        AutoRoute(
          page: CreateProductOrderRoute.page,
          path: "/create_product_request",
        ),

        /// create service request
        AutoRoute(
          page: CreateServiceOrderRoute.page,
          path: '/create_service_request',
        ),

        /// create service request
        AutoRoute(
          page: UserOrderTypeRoute.page,
          path: '/user_order_type',
        ),

        ///  sub category
        AutoRoute(page: SubCategoryRoute.page, path: "/sub_category"),

        /// order create
        AutoRoute(page: OrderCreateRoute.page, path: '/order_create'),

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
        AutoRoute(page: AddAddressRoute.page, path: '/add_address'),

        AutoRoute(page: UserAddressesRoute.page, path: '/my_addresses'),

        /// user ads
        AutoRoute(
          page: UserAdListRoute.page,
          path: '/user_ad_list',
          children: [
            AutoRoute(page: UserAdsRoute.page, path: "user_ads"),
          ],
        ),

        /// ad list actions
        AutoRoute(page: AdListActionsRoute.page, path: '/ad_list_actions'),

        AutoRoute(page: UserCardListRoute.page, path: '/user_card_list'),

        /// user orders
        AutoRoute(page: AddCardRoute.page, path: '/add_card'),
        AutoRoute(
          page: UserOrderListRoute.page,
          path: '/user_order_list',
          children: [
            AutoRoute(
              page: UserOrdersRoute.page,
              path: 'user_orders',
            ),
          ],
        ),

        /// user chat lists
        AutoRoute(
          page: ChatListRoute.page,
          path: '/chat_list',
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
          page: SelectionNestedCategoryRoute.page,
          path: '/selection_nested_category',
        ),

        AutoRoute(
          page: SelectionCategoryRoute.page,
          path: '/selection_category',
        ),

        AutoRoute(
          page: SelectionPaymentTypeRoute.page,
          path: '/selection_payment_type',
        ),

        AutoRoute(
          page: SelectionUserAddressRoute.page,
          path: '/selection_user_address',
        ),

        AutoRoute(
          page: SelectionRegionAndDistrictRoute.page,
          path: '/selection_region_and_district',
        ),

        AutoRoute(
          page: SelectionUserWarehouseRoute.page,
          path: '/selection_user_warehouse',
        ),

        AutoRoute(
          page: SelectionUnitRoute.page,
          path: '/selection_unit',
        )
      ];
}
