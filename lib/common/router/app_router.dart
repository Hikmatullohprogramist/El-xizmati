import 'package:auto_route/auto_route.dart';
import 'package:onlinebozor/presentation/home/home_page.dart';
import 'package:onlinebozor/presentation/login/login_page.dart';
import 'package:onlinebozor/presentation/verify/verify_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/auth/set_language/set_language_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SetLanguageRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: VerifyRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
