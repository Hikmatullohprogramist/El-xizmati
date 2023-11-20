import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_ads/features/inactive_ads/cubit/user_inactive_ads_cubit.dart';

@RoutePage()
class UserInactiveAdsPage extends BasePage<UserInactiveAdsCubit,
    UserInactiveAdsBuildable, UserInactiveAdsListenable> {
  const UserInactiveAdsPage({super.key});

  @override
  Widget builder(BuildContext context, UserInactiveAdsBuildable state) {
    return Scaffold(
      body: Center(
        child: Text("User inactive page"),
      ),
    );
  }
}
