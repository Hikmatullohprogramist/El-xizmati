import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'cubit/auth_with_eds_cubit.dart';

@RoutePage()
class AuthWithEdsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AuthWithEdsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold();
  }
}
