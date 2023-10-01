import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/setting/cubit/setting_cubit.dart';

@RoutePage()
class SettingPage
    extends BasePage<SettingCubit, SettingBuildable, SettingListenable> {
  const SettingPage({super.key});

  @override
  Widget builder(BuildContext context, SettingBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Setting  Page"),
      ),
    );
  }
}
