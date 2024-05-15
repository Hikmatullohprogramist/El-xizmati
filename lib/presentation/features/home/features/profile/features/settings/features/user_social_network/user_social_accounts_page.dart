import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';

import 'cubit/user_social_accounts_cubit.dart';

@RoutePage()
class UserSocialAccountsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserSocialAccountsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        titleText: Strings.settingsSocialNetwork,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Center(
        child: Text("User Social Network page"),
      ),
    );
  }
}
