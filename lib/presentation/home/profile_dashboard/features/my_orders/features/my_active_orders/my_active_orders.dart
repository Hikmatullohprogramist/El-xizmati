import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_orders/features/my_active_orders/cubit/my_active_orders_cubit.dart';

@RoutePage()
class MyActiveOrdersPage extends BasePage<MyActiveOrdersCubit,
    MyActiveOrdersBuildable, MyActiveOrdersListenable> {
  const MyActiveOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, MyActiveOrdersBuildable state) {
    return Scaffold(
      body: Center(child: Text("My Active Order")),
    );
  }
}
