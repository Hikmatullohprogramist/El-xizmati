import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/ad/ad_empty_widget.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/user_orders/features/user_saved_orders/cubit/user_saved_orders_cubit.dart';

import '../../../../../../../../common/core/base_page.dart';

@RoutePage()
class UserSavedOrdersPage extends BasePage<UserSavedOrdersCubit,
    UserSavedOrdersBuildable, UserSavedOrdersListenable> {
  const UserSavedOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, UserSavedOrdersBuildable state) {
    return Scaffold(
      body: Center(
          child: AdEmptyWidget(
        listener: () {},
      )),
    );
  }
}
