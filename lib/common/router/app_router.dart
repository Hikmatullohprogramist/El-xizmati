import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/home/home_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/setting/setting_page.dart';
import 'package:onlinebozor/presentation/verify/verify_page.dart';

import '../../presentation/ad/ad_collection/ad_collection_page.dart';
import '../../presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';
import '../../presentation/ad/ad_detail/ad_detil_page.dart';
import '../../presentation/ad/ad_list/ad_list_page.dart';
import '../../presentation/ad/ad_search/ad_search_page.dart';
import '../../presentation/auth/confirm/confirm_page.dart';
import '../../presentation/auth/login/login_page.dart';
import '../../presentation/auth/register/register_page.dart';
import '../../presentation/auth/set_password/set_password_page.dart';
import '../../presentation/auth/start/auth_start_page.dart';
import '../../presentation/auth/verification/verification_page.dart';
import '../../presentation/common/notification/notification_page.dart';
import '../../presentation/common/popular_categories/popular_categories_page.dart';
import '../../presentation/common/search/search_page.dart';
import '../../presentation/home/card/card_page.dart';
import '../../presentation/home/category/category_page.dart';
import '../../presentation/home/dashboard/dashboard_page.dart';
import '../../presentation/home/favorites/favorites/commodity/commodity_favorites_page.dart';
import '../../presentation/home/favorites/favorites/service/service_favorites_page.dart';
import '../../presentation/home/favorites/favorites_page.dart';
import '../../presentation/home/profile_dashboard/features/add_address/add_address_page.dart';
import '../../presentation/home/profile_dashboard/features/chat_list/chats_list.dart';
import '../../presentation/home/profile_dashboard/features/chat_list/features/buying_chats/buying_chats_page.dart';
import '../../presentation/home/profile_dashboard/features/chat_list/features/chat/chat_page.dart';
import '../../presentation/home/profile_dashboard/features/chat_list/features/saved_chats/saved_chats_page.dart';
import '../../presentation/home/profile_dashboard/features/chat_list/features/selling_chats/selling_chats_page.dart';
import '../../presentation/home/profile_dashboard/features/comparison_detail/comparison_detail_page.dart';
import '../../presentation/home/profile_dashboard/features/message/message_screen.dart';
import '../../presentation/home/profile_dashboard/features/my_active_device/my_active_device_page.dart';
import '../../presentation/home/profile_dashboard/features/my_ads/features/active_ads/my_active_ads.dart';
import '../../presentation/home/profile_dashboard/features/my_ads/features/inactive_ads/my_inactive_ads.dart';
import '../../presentation/home/profile_dashboard/features/my_ads/features/pending_ads/my_pending_ads.dart';
import '../../presentation/home/profile_dashboard/features/my_ads/my_ads_page.dart';
import '../../presentation/home/profile_dashboard/features/my_cards/my_cards_page.dart';
import '../../presentation/home/profile_dashboard/features/my_orders/my_orders_page.dart';
import '../../presentation/home/profile_dashboard/features/my_social_network/my_social_network_page.dart';
import '../../presentation/home/profile_dashboard/features/payment_transaction/features/payment_transaction_filter/payment_transaction_filter_page.dart';
import '../../presentation/home/profile_dashboard/features/payment_transaction/payment_transaction_page.dart';
import '../../presentation/home/profile_dashboard/features/profile_edit/profile_edit_page.dart';
import '../../presentation/home/profile_dashboard/features/profile_viewer/profile_viewer_page.dart';
import '../../presentation/home/profile_dashboard/features/promotion/promotion_page.dart';
import '../../presentation/home/profile_dashboard/profile_dashboard_page.dart';
import '../../presentation/language/set_language/set_language_page.dart';
import '../constants.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        //
        AutoRoute(
            page: SetLanguageRoute.page, path: "/set_language", initial: true),
        AutoRoute(page: AuthStartRoute.page, path: "/auth_start"),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(
            page: SetPasswordRoute.page, path: '/ser_password', initial: false),

        //home screen
        AutoRoute(
            page: HomeRoute.page,
            path: '/home',
            initial: false,
            children: [
              AutoRoute(page: DashboardRoute.page, path: 'dashboard'),
              AutoRoute(page: CategoryRoute.page, path: 'category'),
              AutoRoute(page: FavoritesRoute.page, path: 'favorite', children: [
                AutoRoute(
                    page: CommodityFavoritesRoute.page,
                    path: 'commodity_favorites'),
                AutoRoute(
                    page: ServiceFavoritesRoute.page, path: 'service_favorites')
              ]),
              AutoRoute(page: CardRoute.page, path: 'card'),
              AutoRoute(page: ProfileDashboardRoute.page, path: 'profile')
            ]),

        // Ads collection
        AutoRoute(page: AdCollectionRoute.page, path: "/ads_collection"),
        AutoRoute(page: AdListRoute.page, path: '/ads_list'),
        AutoRoute(page: AdDetailRoute.page, path: '/ads_detail'),
        AutoRoute(page: AdSearchRoute.page, path: '/ad-search'),

        //  common page
        AutoRoute(
            page: PopularCategoriesRoute.page, path: '/popular_categories'),
        AutoRoute(page: SearchRoute.page, path: '/search'),
        AutoRoute(page: NotificationRoute.page, path: '/notification'),

        //   profile page
        AutoRoute(page: ProfileViewerRoute.page, path: '/profile_viewer'),
        AutoRoute(page: AddAddressRoute.page, path: '/add_address'),
        AutoRoute(page: MyAdsRoute.page, path: '/my_ads'),
        AutoRoute(page: MyCardsRoute.page, path: '/my_cards'),
        AutoRoute(page: MyOrdersRoute.page, path: '/my_orders'),
        AutoRoute(page: MessageRoute.page, path: '/message'),
        AutoRoute(
            page: PaymentTransactionRoute.page, path: '/payment_transaction'),
        AutoRoute(page: ProfileEditRoute.page, path: '/profile_edit'),
        AutoRoute(page: ComparisonDetailRoute.page, path: '/comparison_detail'),
        AutoRoute(page: PromotionRoute.page, path: '/promotion'),
        AutoRoute(page: SettingRoute.page, path: '/setting'),
        AutoRoute(page: MyActiveDeviceRoute.page, path: '/my_active_device'),
        AutoRoute(page: MySocialNetworkRoute.page, path: '/my_social_network'),
      ];
}
