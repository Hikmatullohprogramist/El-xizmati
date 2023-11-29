import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/ad_empty_widget.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_orders/features/user_pending_orders/cubit/user_pending_orders_cubit.dart';

import '../../../../../../../common/core/base_page.dart';

@RoutePage()
class UserPendingOrdersPage extends BasePage<UserPendingOrdersCubit,
    UserPendingOrdersBuildable, UserPendingOrdersListenable> {
  const UserPendingOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, UserPendingOrdersBuildable state) {
    return Scaffold(
      body: Center(
        child: AdEmptyWidget(
          callBack: () {},
        ),
      ),
    );
  }
}
