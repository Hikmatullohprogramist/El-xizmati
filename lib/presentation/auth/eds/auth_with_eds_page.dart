import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/auth/eds/cubit/page_cubit.dart';

@RoutePage()
class AuthWithEdsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AuthWithEdsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold();
  }
}
