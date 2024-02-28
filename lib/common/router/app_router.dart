import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebozor/presentation/common/language/change_language/page.dart';
import 'package:onlinebozor/presentation/creation/create_product_order/page.dart';
import 'package:onlinebozor/presentation/creation/create_service_order/page.dart';
import 'package:onlinebozor/presentation/home/page.dart';

import '../../data/responses/address/user_address_response.dart';
import '../../data/responses/category/category/category_response.dart';
import '../../data/responses/currencies/currency_response.dart';
import '../../data/responses/payment_type/payment_type_response.dart';
import '../../data/responses/region/region_response.dart';
import '../../data/responses/unit/unit_response.dart';
import '../../data/responses/user_ad/user_ad_response.dart';
import '../../domain/models/ad/ad_list_type.dart';
import '../../domain/models/ad/ad_type.dart';
import '../../domain/models/ad/user_ad_status.dart';
import '../../domain/models/order/order_type.dart';
import '../../domain/models/order/user_order_status.dart';
import '../../presentation/ad/ad_detail/page.dart';
import '../../presentation/ad/ad_list/page.dart';
import '../../presentation/ad/ad_list_actions/page.dart';
import '../../presentation/ad/ad_list_by_type/page.dart';
import '../../presentation/ad/user_ad_detail/page.dart';
import '../../presentation/auth/confirm/page.dart';
import '../../presentation/auth/eds/page.dart';
import '../../presentation/auth/one_id/page.dart';
import '../../presentation/auth/set_password/page.dart';
import '../../presentation/auth/start/page.dart';
import '../../presentation/auth/verification/page.dart';
import '../../presentation/common/favorites/page.dart';
import '../../presentation/common/favorites/features/product/page.dart';
import '../../presentation/common/favorites/features/service/page.dart';
import '../../presentation/common/image_viewer/image_viewer_page.dart';
import '../../presentation/common/image_viewer/locale_image_viewer_page.dart';
import '../../presentation/common/language/set_language/page.dart';
import '../../presentation/common/notification/page.dart';
import '../../presentation/common/popular_categories/page.dart';
import '../../presentation/common/search/page.dart';
import '../../presentation/common/selection_address/page.dart';
import '../../presentation/common/selection_category/page.dart';
import '../../presentation/common/selection_currency/page.dart';
import '../../presentation/common/selection_nested_category/page.dart';
import '../../presentation/common/selection_payment_type/page.dart';
import '../../presentation/common/selection_unit/page.dart';
import '../../presentation/common/selection_user_address/page.dart';
import '../../presentation/common/selection_user_warehouse/page.dart';
import '../../presentation/creation/create_ad_start/page.dart';
import '../../presentation/creation/create_order_start/page.dart';
import '../../presentation/creation/create_product_ad/page.dart';
import '../../presentation/creation/create_service_ad/page.dart';
import '../../presentation/home/features/cart/page.dart';
import '../../presentation/home/features/cart/features/order_create/page.dart';
import '../../presentation/home/features/category/page.dart';
import '../../presentation/home/features/category/features/page.dart';
import '../../presentation/home/features/create_ad_chooser/page.dart';
import '../../presentation/home/features/dashboard/page.dart';
import '../../presentation/home/features/profile/features/chat_list/page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/buying_chats/page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/chat/page_page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/saved_chats/page.dart';
import '../../presentation/home/features/profile/features/chat_list/features/selling_chats/page.dart';
import '../../presentation/home/features/profile/features/comparison_detail/page.dart';
import '../../presentation/home/features/profile/features/payment_transaction/features/payment_transaction_filter/page.dart';
import '../../presentation/home/features/profile/features/payment_transaction/page.dart';
import '../../presentation/home/features/profile/features/profile_view/features/profile_edit/page.dart';
import '../../presentation/home/features/profile/features/profile_view/features/registration/page.dart';
import '../../presentation/home/features/profile/features/profile_view/page.dart';
import '../../presentation/home/features/profile/features/promotion/page.dart';
import '../../presentation/home/features/profile/features/settings/features/notification_settings/page.dart';
import '../../presentation/home/features/profile/features/settings/features/user_active_device/page.dart';
import '../../presentation/home/features/profile/features/settings/features/user_social_network/page.dart';
import '../../presentation/home/features/profile/features/settings/page.dart';
import '../../presentation/home/features/profile/features/user_address/features/add_address/page.dart';
import '../../presentation/home/features/profile/features/user_address/page.dart';
import '../../presentation/home/features/profile/features/user_ads/features/ad_list/page.dart';
import '../../presentation/home/features/profile/features/user_ads/page.dart';
import '../../presentation/home/features/profile/features/user_cards/features/add_card/page.dart';
import '../../presentation/home/features/profile/features/user_cards/page.dart';
import '../../presentation/home/features/profile/features/user_order_type/page.dart';
import '../../presentation/home/features/profile/features/user_orders/features/user_order_list/page.dart';
import '../../presentation/home/features/profile/features/user_orders/page.dart';
import '../../presentation/home/features/profile/features/wallet_filling/page.dart';
import '../../presentation/home/features/profile/page.dart';

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
        AutoRoute(page: ConfirmRoute.page, path: '/confirmation'),
        AutoRoute(page: VerificationRoute.page, path: '/verification'),
        AutoRoute(page: SetPasswordRoute.page, path: '/set_password'),
        AutoRoute(page: EdsRoute.page, path: '/eds'),
        AutoRoute(page: LoginWithOneIdRoute.page, path: "/login_with_one_id"),

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
        AutoRoute(page: NotificationRoute.page, path: '/notification'),

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

        /// my ads
        AutoRoute(
          page: UserAdsRoute.page,
          path: '/my_ads',
          children: [
            AutoRoute(page: UserAdListRoute.page, path: "all_ads"),
          ],
        ),

        /// ad list actions
        AutoRoute(page: AdListActionsRoute.page, path: '/ad_list_actions'),

        AutoRoute(page: UserCardsRoute.page, path: '/my_cards'),

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

        /// My chat lists
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
          page: SelectionAddressRoute.page,
          path: '/selection_address',
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
