import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../common/widgets/app_bar/common_search_bar.dart';
import 'cubit/dashboard_cubit.dart';

@RoutePage()
class DashboardPage
    extends BasePage<DashboardCubit, DashboardBuildable, DashboardListenable> {
  const DashboardPage({super.key});

  @override
  Widget builder(BuildContext context, DashboardBuildable state) {
    return Scaffold(
      appBar: CommonSearchBar(
        onPressedMic: () {},
        onPressedNotification: () {
          context.router.push(NotificationRoute());
        },
        onPressedSearch: () {
          context.router.push(SearchRoute());
        },
      ),
      backgroundColor: Colors.white,
      body: Center(child: Text("dashboard page")),
    );
  }
}
