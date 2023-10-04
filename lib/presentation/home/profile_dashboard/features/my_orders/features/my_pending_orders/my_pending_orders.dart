import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_orders/features/my_pending_orders/cubit/my_pending_orders_cubit.dart';

@RoutePage()
class MyPendingOrdersPage extends BasePage<MyPendingOrdersCubit,
    MyPendingOrdersBuildable, MyPendingOrdersListenable> {
  const MyPendingOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, MyPendingOrdersBuildable state) {
    return Scaffold(
      body: Center(
        child: Text("My penfing order"),
      ),
    );
  }
}
