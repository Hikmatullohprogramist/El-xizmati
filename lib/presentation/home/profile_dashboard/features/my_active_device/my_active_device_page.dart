import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_active_device/cubit/my_active_device_cubit.dart';

@RoutePage()
class MyActiveDevicePage extends BasePage<MyActiveDeviceCubit,
    MyActiveDeviceBuildable, MyActiveDeviceListenable> {
  const MyActiveDevicePage({super.key});

  @override
  Widget builder(BuildContext context, MyActiveDeviceBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Active Device "),
      ),
    );
  }
}
