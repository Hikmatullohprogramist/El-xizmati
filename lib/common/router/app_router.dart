import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/home/home_page.dart';
import 'package:onlinebozor/presentation/login/login_page.dart';
import 'package:onlinebozor/presentation/verify/verify_page.dart';

import '../../presentation/auth/confirm/auth_confirm_page.dart';
import '../../presentation/auth/set_language/set_language_page.dart';
import '../../presentation/auth/set_password/set_password_page.dart';
import '../../presentation/auth/start/auth_start_page.dart';

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
