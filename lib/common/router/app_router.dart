import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/home/home_page.dart';
import 'package:onlinebozor/presentation/login/login_page.dart';
import 'package:onlinebozor/presentation/verify/verify_page.dart';

import '../../presentation/ads/ads_collection /ads_collection_page.dart';
import '../../presentation/ads/ads_detail/ads_detail_page.dart';
import '../../presentation/ads/ads_list/ads_list_page.dart';
import '../../presentation/ads/ads_search/ads_search_page.dart';
import '../../presentation/auth/confirm/auth_confirm_page.dart';
import '../../presentation/auth/set_language/set_language_page.dart';
import '../../presentation/auth/set_password/set_password_page.dart';
import '../../presentation/auth/start/auth_start_page.dart';
import '../../presentation/common/notification/notification_page.dart';
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

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes =>
      [
        AutoRoute(
            page: SetLanguageRoute.page, path: "/set_language", initial: true),
        AutoRoute(page: AuthStartRoute.page,path:  "/auth_start"),
        AutoRoute(page: LoginRoute.page, ),
        AutoRoute(page: VerifyRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
