import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_ads/features/pending_ads/cubit/my_pending_ads_cubit.dart';

@RoutePage()
class MyPendingAdsPage extends BasePage<MyPendingAdsCubit,
    MyPendingAdsBuildable, MyPendingAdsListenable> {
  const MyPendingAdsPage({super.key});

  @override
  Widget builder(BuildContext context, MyPendingAdsBuildable state) {
    return Scaffold(
      body: Center(child: Text("My pending ads page")),
    );
  }
}
