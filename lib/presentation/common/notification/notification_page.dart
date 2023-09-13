import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';

import 'cubit/notification_cubit.dart';

@RoutePage()
class NotificationPage extends BasePage<NotificationCubit,
    NotificationBuildable, NotificationListenable> {
  const NotificationPage({super.key});

  @override
  Widget builder(BuildContext context, NotificationBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
