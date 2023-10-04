import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_ads/features/active_ads/cubit/my_active_ads_cubit.dart';

@RoutePage()
class MyActiveAdsPage extends BasePage<MyActiveAdsCubit, MyActiveAdsBuildable,
    MyActiveAdsListenable> {
  const MyActiveAdsPage({super.key});

  @override
  Widget builder(BuildContext context, MyActiveAdsBuildable state) {
    return Scaffold(
      body: Center(
        child: Text("My Active Ads Page"),
      ),
    );
  }
}
