import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/cart/features%20/order_create/cubit/order_create_cubit.dart';

@RoutePage()
class OrderCreatePage extends BasePage<OrderCreateCubit, OrderCreateBuildable,
    OrderCreateListenable> {
  const OrderCreatePage({super.key});

  @override
  Widget builder(BuildContext context, OrderCreateBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Order Create Screen ")),
    );
  }
}
