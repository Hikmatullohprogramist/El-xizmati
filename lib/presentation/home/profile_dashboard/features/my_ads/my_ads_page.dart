import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_ads/cubit/my_ads_cubit.dart';

@RoutePage()
class MyAdsPage extends BasePage<MyAdsCubit, MyAdsBuildable, MyAdsListenable> {
  const MyAdsPage({super.key});

  @override
  Widget builder(BuildContext context, MyAdsBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("My Ads Screen")),
    );
  }
}
