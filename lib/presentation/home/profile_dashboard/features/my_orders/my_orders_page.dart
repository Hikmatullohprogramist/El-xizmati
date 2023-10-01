import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_orders/cubit/my_orders_cubit.dart';

@RoutePage()
class MyOrdersPage
    extends BasePage<MyOrdersCubit, MyOrdersBuildable, MyOrdersListenable> {
  const MyOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, MyOrdersBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("My orders Screen")),
    );
  }
}
