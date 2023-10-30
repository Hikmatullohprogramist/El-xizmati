import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/cart_cubit.dart';

@RoutePage()
class CartPage extends BasePage<CartCubit, CartBuildable, CartListenable> {
  const CartPage({super.key});

  @override
  Widget builder(BuildContext context, CartBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
