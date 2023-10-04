import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_ads/features/inactive_ads/cubit/my_inactive_ads_cubit.dart';

@RoutePage()
class MyInactiveAdsPage extends BasePage<MyInactiveAdsCubit,
    MyInactiveAdsBuildable, MyInactiveAdsListenable> {
  const MyInactiveAdsPage({super.key});

  @override
  Widget builder(BuildContext context, MyInactiveAdsBuildable state) {
    return Scaffold(
      body: Center(
        child: Text("My inactive page"),
      ),
    );
  }
}
