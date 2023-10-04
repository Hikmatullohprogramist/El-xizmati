import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_orders/features/my_saved_orders/cubit/my_saved_orders_cubit.dart';

@RoutePage()
class MySavedOrdersPage extends BasePage<MySavedOrdersCubit,
    MySavedOrdersBuildable, MySavedOrdersListenable> {
  const MySavedOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, MySavedOrdersBuildable state) {
    return Scaffold(
      body: Center(
        child: Text("My saved orders"),
      ),
    );
  }
}
