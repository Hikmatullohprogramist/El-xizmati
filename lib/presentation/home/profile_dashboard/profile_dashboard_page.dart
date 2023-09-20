import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/cubit/profile_dashboard_cubit.dart';

@RoutePage()
class ProfileDashboardPage extends BasePage<ProfileDashboardCubit,
    ProfileDashboardBuildable, ProfileDashboardListenable> {
  const ProfileDashboardPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileDashboardBuildable state) {
    return Center(
      child: Text("ProfileDashboard"),
    );
  }
}
