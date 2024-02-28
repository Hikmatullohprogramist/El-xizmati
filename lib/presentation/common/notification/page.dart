import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../common/widgets/app_bar/default_app_bar.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class NotificationPage extends BasePage<PageCubit, PageState, PageEvent> {
  const NotificationPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        Strings.notificationTitle,
        () => context.router.pop(),
      ),
      body: Center(
        child: Text(Strings.noHaveNotification),
      ),
    );
  }
}
