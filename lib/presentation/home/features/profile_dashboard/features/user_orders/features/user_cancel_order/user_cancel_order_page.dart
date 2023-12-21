import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/user_orders/features/user_cancel_order/cubit/user_cancel_order_cubit.dart';

import '../../../../../../../../domain/util.dart';

@RoutePage()
class UserCancelOrderPage extends BasePage<UserCancelOrderCubit,
    UserCancelOrderBuildable, UserCancelOrderListenable> {
  const UserCancelOrderPage(this.orderType, {super.key});

  final OrderType orderType;

  @override
  void init(BuildContext context) {
    context.read<UserCancelOrderCubit>().setInitialOrderType(orderType);
  }

  @override
  Widget builder(BuildContext context, UserCancelOrderBuildable state) {
    return Scaffold();
  }
}
