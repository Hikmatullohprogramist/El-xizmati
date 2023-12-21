import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/widgets/ad/ad_empty_widget.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/user_orders/features/user_pending_orders/cubit/user_pending_orders_cubit.dart';

import '../../../../../../../../domain/util.dart';

@RoutePage()
class UserPendingOrdersPage extends BasePage<UserPendingOrdersCubit,
    UserPendingOrdersBuildable, UserPendingOrdersListenable> {
  const UserPendingOrdersPage(this.orderType, {super.key});

  final OrderType orderType;

  @override
  void init(BuildContext context) {
    context.read<UserPendingOrdersCubit>().setInitialOrderType(orderType);
  }

  @override
  Widget builder(BuildContext context, UserPendingOrdersBuildable state) {
    return Scaffold(
      body: Center(
        child: AdEmptyWidget(
          listener: () {},
        ),
      ),
    );
  }
}
