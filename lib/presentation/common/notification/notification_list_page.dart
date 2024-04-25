import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../common/widgets/app_bar/default_app_bar.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class NotificationListPage extends BasePage<PageCubit, PageState, PageEvent> {
  const NotificationListPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: Strings.notificationTitle,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Center(
        child: Text(Strings.noHaveNotification),
      ),
    );
  }
}
