import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/home/home_page.dart';
import 'package:onlinebozor/presentation/verify/verify_page.dart';

import '../../presentation/ads/ads_collection /ads_collection_page.dart';
import '../../presentation/ads/ads_detail/ads_detail_page.dart';
import '../../presentation/ads/ads_list/ads_list_page.dart';
import '../../presentation/ads/ads_list/cubit/ads_list_cubit.dart';
import '../../presentation/ads/ads_search/ads_search_page.dart';
import '../../presentation/auth/confirm/confirm_page.dart';
import '../../presentation/auth/login/login_page.dart';
import '../../presentation/auth/register/register_page.dart';
import '../../presentation/auth/set_password/set_password_page.dart';
import '../../presentation/auth/start/auth_start_page.dart';
import '../../presentation/auth/verification/verification_page.dart';
import '../../presentation/common/notification/notification_page.dart';
import '../../presentation/common/search/search_page.dart';
import '../../presentation/home/card/card_page.dart';
import '../../presentation/home/category/category_page.dart';
import '../../presentation/home/dashboard/dashboard_page.dart';
import '../../presentation/home/favorites/favorites_page.dart';
import '../../presentation/home/profile_dashboard/features/addaddress/add_address_page.dart';
import '../../presentation/home/profile_dashboard/features/comparisondetail/comparison_detail_page.dart';
import '../../presentation/home/profile_dashboard/features/mycards/my_cards_page.dart';
import '../../presentation/home/profile_dashboard/features/paymenttransaction/payment_transaction_page.dart';
import '../../presentation/home/profile_dashboard/features/profileedit/profile_edit_page.dart';
import '../../presentation/home/profile_dashboard/features/profileviewer/profile_viewer_page.dart';
import '../../presentation/home/profile_dashboard/profile_dashboard_page.dart';
import '../../presentation/language/set_language/set_language_page.dart';

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
              AutoRoute(page: FavoritesRoute.page, path: 'favorite'),
              AutoRoute(page: CardRoute.page, path: 'card'),
              AutoRoute(page: ProfileDashboardRoute.page, path: 'profile')
            ]),

        // Ads collection
        AutoRoute(page: AdsCollectionRoute.page, path: "/ads_collection"),
        AutoRoute(page: AdsListRoute.page, path: '/ads_list'),
        AutoRoute(page: AdsDetailRoute.page, path: '/ads_detail'),

        //  common page
        AutoRoute(page: SearchRoute.page, path: '/search'),
        AutoRoute(page: NotificationRoute.page, path: '/notification'),

        //   profile page
        AutoRoute(page: ProfileViewerRoute.page, path: '/profile_viewer'),
        AutoRoute(page: AddAddressRoute.page, path: '/add_address'),
        AutoRoute(page: MyCardsRoute.page, path: '/my_cards'),
        AutoRoute(page: PaymentTransactionRoute.page, path: '/payment_transaction'),
        AutoRoute(page: ProfileEditRoute.page, path: '/profile_edit'),
        AutoRoute(page: ComparisonDetailRoute.page, path: '/comparison_detail')
      ];
}
