import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/user_orders/features/user_review_orders/cubit/user_review_orders_cubit.dart';

import '../../../../../../../../domain/util.dart';

@RoutePage()
class UserReviewOrdersPage extends BasePage<UserReviewOrdersCubit,
    UserReviewOrdersBuildable, UserReviewOrdersListenable> {
  const UserReviewOrdersPage(this.orderType, {super.key});

  final OrderType orderType;

  @override
  void init(BuildContext context) {
    context.read<UserReviewOrdersCubit>().setInitialOrderType(orderType);
  }

  @override
  Widget builder(BuildContext context, UserReviewOrdersBuildable state) {
    return Scaffold();
  }
}
