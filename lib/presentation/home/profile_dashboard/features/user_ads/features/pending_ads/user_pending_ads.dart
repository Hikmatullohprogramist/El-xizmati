import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_ads/features/pending_ads/cubit/user_pending_ads_cubit.dart';

@RoutePage()
class UserPendingAdsPage extends BasePage<UserPendingAdsCubit,
    UserPendingAdsBuildable, UserPendingAdsListenable> {
  const UserPendingAdsPage({super.key});

  @override
  Widget builder(BuildContext context, UserPendingAdsBuildable state) {
    return Scaffold(
      body: Center(child: Text("User pending ads page")),
    );
  }
}
