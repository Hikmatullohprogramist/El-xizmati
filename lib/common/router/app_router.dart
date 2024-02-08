import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/common/language/change_language/change_language_page.dart';
import 'package:onlinebozor/presentation/home/home_page.dart';

import '../../data/responses/address/user_address_response.dart';
import '../../data/responses/category/category/category_response.dart';
import '../../data/responses/user_ad/user_ad_response.dart';
import '../../domain/models/ad/ad_list_type.dart';
import '../../domain/models/ad/ad_type.dart';
import '../../domain/models/order/order_type.dart';
import '../../presentation/ad/ad_detail/ad_detail_page.dart';
import '../../presentation/ad/ad_list/ad_list_page.dart';
import '../../presentation/ad/ad_list_by_type/ad_list_by_type_page.dart';
import '../../presentation/ad/user_ad_detail/user_ad_detail.dart';
import '../../presentation/auth/confirm/confirm_page.dart';
import '../../presentation/auth/eds/eds_page.dart';
import '../../presentation/auth/one_id/login_with_one_id_page.dart';
import '../../presentation/auth/set_password/set_password_page.dart';
import '../../presentation/auth/start/auth_start_page.dart';
import '../../presentation/auth/verification/verification_page.dart';
import '../../presentation/common/favorites/favorites/product/product_favorites_page.dart';
import '../../presentation/common/favorites/favorites/service/service_favorites_page.dart';
import '../../presentation/common/favorites/favorites_page.dart';
import '../../presentation/common/language/set_language/set_language_page.dart';
import '../../presentation/common/notification/notification_page.dart';
import '../../presentation/common/photo_view/photo_view_page.dart';
import '../../presentation/common/popular_categories/popular_categories_page.dart';
import '../../presentation/common/search/search_page.dart';
import '../../presentation/common/selection_address/selection_address_page.dart';
import '../../presentation/common/selection_category/selection_category_page.dart';
import '../../presentation/common/selection_user_address/selection_user_address.dart';
import '../../presentation/creation/create_ad_start/create_ad_start_page.dart';
import '../../presentation/creation/create_product_ad/create_product_ad_page.dart';
import '../../presentation/creation/create_request_start/create_request_start_page.dart';
import '../../presentation/creation/create_service_ad/create_service_ad_page.dart';
import '../../presentation/creation/product_order/product_order_create_page.dart';
import '../../presentation/creation/service_order/service_order_create_page.dart';
import '../../presentation/home/features/ad_creation_start/ad_creation_start_page.dart';
import '../../presentation/home/features/cart/cart_page.dart';
import '../../presentation/home/features/cart/features /order_create/order_create_page.dart';
import '../../presentation/home/features/category/category_page.dart';
import '../../presentation/home/features/category/features/sub_category_page.dart';
import '../../presentation/home/features/dashboard/dashboard_page.dart';
import '../../presentation/home/features/profile/features/chat_list/chats_list.dart';
import '../../presentation/home/features/profile/features/chat_list/features/buying_chats/buying_chats_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/chat/chat_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/saved_chats/saved_chats_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/selling_chats/selling_chats_page.dart';
import '../../presentation/home/features/profile/features/comparison_detail/comparison_detail_page.dart';
import '../../presentation/home/features/profile/features/payment_transaction/features/payment_transaction_filter/payment_transaction_filter_page.dart';
import '../../presentation/home/features/profile/features/payment_transaction/payment_transaction_page.dart';
import '../../presentation/home/features/profile/features/profile_view/features/profile_edit/profile_edit_page.dart';
import '../../presentation/home/features/profile/features/profile_view/features/registration/registration_page.dart';
import '../../presentation/home/features/profile/features/profile_view/profile_view_page.dart';
import '../../presentation/home/features/profile/features/promotion/promotion_page.dart';
import '../../presentation/home/features/profile/features/settings/features/notification_settings/notification_setting_page.dart';
import '../../presentation/home/features/profile/features/settings/features/user_active_device/user_active_device_page.dart';
import '../../presentation/home/features/profile/features/settings/features/user_social_network/user_social_network_page.dart';
import '../../presentation/home/features/profile/features/settings/settings_page.dart';
import '../../presentation/home/features/profile/features/user_address/features/add_address/add_address_page.dart';
import '../../presentation/home/features/profile/features/user_address/user_addresses_page.dart';
import '../../presentation/home/features/profile/features/user_ads/features/active_ads/user_active_ads.dart';
import '../../presentation/home/features/profile/features/user_ads/features/all_ads/user_all_ads_page.dart';
import '../../presentation/home/features/profile/features/user_ads/features/cancel_ads/user_cancel_ads_page.dart';
import '../../presentation/home/features/profile/features/user_ads/features/inactive_ads/user_inactive_ads.dart';
import '../../presentation/home/features/profile/features/user_ads/features/pending_ads/user_pending_ads.dart';
import '../../presentation/home/features/profile/features/user_ads/user_ads_page.dart';
import '../../presentation/home/features/profile/features/user_cards/features /add_card/add_cart_page.dart';
import '../../presentation/home/features/profile/features/user_cards/user_cards_page.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_accept_orders/user_accept_orders_page.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_all_orders/user_all_orders_page.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_cancel_order/user_cancel_order_page.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_pending_orders/user_pending_orders.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_reject_orders/user_reject_orders_page.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_review_orders/user_review_orders_page.dart';
import '../../presentation/home/features/profile/features/user_orders/user_orders_page.dart';
import '../../presentation/home/features/profile/features/wallet_filling/wallet_filling_page.dart';
import '../../presentation/home/features/profile/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //
        AutoRoute(
          page: SetLanguageRoute.page,
          path: "/set_language",
          initial: true,
        ),
        AutoRoute(page: AuthStartRoute.page, path: "/auth_start"),
        AutoRoute(page: ConfirmRoute.page, path: '/confirmation'),
        AutoRoute(page: VerificationRoute.page, path: '/verification'),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SetPasswordRoute.page, path: '/set_password'),
        AutoRoute(page: EdsRoute.page, path: '/eds'),
        AutoRoute(page: LoginWithOneIdRoute.page, path: "/login_with_one_id"),

        //home screen
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
              page: AdCreationStartRoute.page,
              path: 'ad_creation_start',
            ),
            AutoRoute(page: CartRoute.page, path: 'cart', maintainState: false),
            AutoRoute(page: ProfileRoute.page, path: 'profile')
          ],
        ),

        AutoRoute(
          page: FavoritesRoute.page,
          path: '/favorite',
          maintainState: true,
          children: [
            AutoRoute(
              page: ProductFavoritesRoute.page,
              path: 'product_favorites',
              maintainState: false,
            ),
            AutoRoute(
              page: ServiceFavoritesRoute.page,
              path: 'service_favorites',
              maintainState: false,
            )
          ],
        ),

        // create product ad
        AutoRoute(
          page: CreateProductAdRoute.page,
          path: '/create_product_ad',
        ),

        // create service ad
        AutoRoute(
          page: CreateServiceAdRoute.page,
          path: '/create_service_ad',
        ),

        // create request start
        AutoRoute(
          page: CreateRequestStartRoute.page,
          path: "/create_request_start",
        ),

        // create product request
        AutoRoute(
          page: ProductOrderCreateRoute.page,
          path: "/product_order_create",
        ),

        // create service request
        AutoRoute(
          page: ServiceOrderCreateRoute.page,
          path: '/service_order_create',
        ),

        //  sub category
        AutoRoute(page: SubCategoryRoute.page, path: "/sub_category"),

        // order create
        AutoRoute(page: OrderCreateRoute.page, path: '/order_create'),

        // Ads collection
        AutoRoute(page: AdListByTypeRoute.page, path: "/ads_collection"),
        AutoRoute(
          page: AdListRoute.page,
          path: '/ads_list',
          maintainState: false,
        ),
        AutoRoute(page: AdDetailRoute.page, path: '/ads_detail'),
        //  common page
        AutoRoute(
          page: PopularCategoriesRoute.page,
          path: '/popular_categories',
        ),
        AutoRoute(page: SearchRoute.page, path: '/search'),
        AutoRoute(page: NotificationRoute.page, path: '/notification'),
        AutoRoute(page: PhotoViewRoute.page, path: '/photo_view'),

        //   profile page
        AutoRoute(page: WalletFillingRoute.page, path: '/wallet_filling'),
        AutoRoute(page: ProfileViewRoute.page, path: '/profile_viewer'),
        AutoRoute(page: AddAddressRoute.page, path: '/add_address'),
        AutoRoute(page: UserAddressesRoute.page, path: '/my_addresses'),
        AutoRoute(page: UserAdsRoute.page, path: '/my_ads', children: [
          AutoRoute(page: UserAllAdsRoute.page, path: "all_ads"),
          AutoRoute(page: UserActiveAdsRoute.page, path: 'active_ads'),
          AutoRoute(page: UserPendingAdsRoute.page, path: 'pending_ads'),
          AutoRoute(page: UserInactiveAdsRoute.page, path: 'inactive_ads'),
          AutoRoute(page: UserCancelAdsRoute.page, path: 'cancel_ads')
        ]),
        AutoRoute(page: UserCardsRoute.page, path: '/my_cards'),
        AutoRoute(page: AddCardRoute.page, path: '/add_card'),
        AutoRoute(page: UserOrdersRoute.page, path: '/user_orders', children: [
          AutoRoute(page: UserAllOrdersRoute.page, path: 'user_all_order'),
          AutoRoute(
              page: UserPendingOrdersRoute.page, path: 'user_pending_orders'),
          AutoRoute(
              page: UserRejectOrdersRoute.page, path: 'user_reject_order'),
          AutoRoute(page: UserCancelOrderRoute.page, path: 'user_cancel_order'),
          AutoRoute(
              page: UserReviewOrdersRoute.page, path: 'user_review_order'),
          AutoRoute(
              page: UserAcceptOrdersRoute.page, path: 'user_accept_order'),
        ]),
        AutoRoute(page: ChatListRoute.page, path: '/chat_list', children: [
          AutoRoute(page: SellingChatsRoute.page, path: 'selling'),
          AutoRoute(page: BuyingChatsRoute.page, path: 'buying'),
          AutoRoute(page: SavedChatsRoute.page, path: 'saved')
        ]),
        AutoRoute(page: ChatRoute.page, path: '/chat'),
        AutoRoute(
            page: PaymentTransactionRoute.page, path: '/payment_transaction'),
        AutoRoute(
            page: PaymentTransactionFilterRoute.page,
            path: '/payment_transaction_filter'),
        AutoRoute(page: ProfileEditRoute.page, path: '/profile_edit'),
        AutoRoute(page: RegistrationRoute.page, path: '/identified'),
        AutoRoute(page: ComparisonDetailRoute.page, path: '/comparison_detail'),
        AutoRoute(page: PromotionRoute.page, path: '/promotion'),
        AutoRoute(page: SettingRoute.page, path: '/setting'),
        AutoRoute(page: UserActiveDeviceRoute.page, path: '/my_active_device'),
        AutoRoute(
          page: UserSocialNetworkRoute.page,
          path: '/my_social_network',
        ),
        AutoRoute(
          page: NotificationSettingRoute.page,
          path: '/notification_setting',
        ),
        AutoRoute(page: UserAdDetailRoute.page, path: "/user_ad_detail"),
        AutoRoute(page: ChangeLanguageRoute.page, path: '/change_language'),

        AutoRoute(
          page: SelectionCategoryRoute.page,
          path: '/selection_category',
        ),

        AutoRoute(
          page: SelectionUserAddressRoute.page,
          path: '/selection_user_address',
        ),

        AutoRoute(
          page: SelectionAddressRoute.page,
          path: '/selection_address',
        )
      ];
}
