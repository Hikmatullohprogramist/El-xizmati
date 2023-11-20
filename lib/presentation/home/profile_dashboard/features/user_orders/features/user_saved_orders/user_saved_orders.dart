import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/widgets/ad_empty_widget.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_orders/features/user_saved_orders/cubit/user_saved_orders_cubit.dart';

@RoutePage()
class UserSavedOrdersPage extends BasePage<UserSavedOrdersCubit,
    UserSavedOrdersBuildable, UserSavedOrdersListenable> {
  const UserSavedOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, UserSavedOrdersBuildable state) {
    return Scaffold(
      body: Center(
          child: AdEmptyWidget(
        callBack: () {},
      )),
    );
  }
}
