import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';

import 'notification_list_cubit.dart';

@RoutePage()
class NotificationListPage extends BasePage<NotificationListCubit,
    NotificationListState, NotificationListEvent> {
  const NotificationListPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, NotificationListState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: Strings.notificationTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Center(
        child: Text(Strings.noHaveNotification),
      ),
    );
  }
}
