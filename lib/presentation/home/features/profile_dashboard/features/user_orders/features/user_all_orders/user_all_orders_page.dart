import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/user_orders/features/user_all_orders/cubit/user_all_orders_cubit.dart';

import '../../../../../../../../domain/util.dart';

@RoutePage()
class UserAllOrdersPage extends BasePage<UserAllOrdersCubit,
    UserAllOrdersBuildable, UserAllOrdersListenable> {
  const UserAllOrdersPage(this.orderType, {super.key});

  final OrderType orderType;

  @override
  void init(BuildContext context) {
    context.read<UserAllOrdersCubit>().setInitialOrderType(orderType);
  }

  @override
  Widget builder(BuildContext context, UserAllOrdersBuildable state) {
    return Scaffold();
  }
}
