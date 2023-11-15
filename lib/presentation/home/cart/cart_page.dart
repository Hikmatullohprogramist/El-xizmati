import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/app_diverder.dart';
import 'package:onlinebozor/common/widgets/cart/cart_widget.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/domain/model/ad_model.dart';

import 'cubit/cart_cubit.dart';

@RoutePage()
class CartPage extends BasePage<CartCubit, CartBuildable, CartListenable> {
  const CartPage({super.key});

  @override
  Widget builder(BuildContext context, CartBuildable state) {
    var formatter = NumberFormat('###,000');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: "Корзина".w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        // actions: [
        //   if (true)
        //     CommonButton(
        //         type: ButtonType.text,
        //         onPressed: () {},
        //         child: "Выбрать все".w(500).s(12).c(Color(0xFF5C6AC3)))
        // ],
      ),
      body: Column(children: [
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: false,
            children: [
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
              CartWidget(
                  addItem: (AdModel result) {},
                  minusItem: (AdModel result) {},
                  deleteItem: (AdModel result) {},
                  addFavorite: (AdModel result) {}),
            ],
          ),
        ),
        AppDivider(height: 2,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              "Товары не выбраны".w(400).s(12).c(Color(0xFF41455E)),
              Spacer(),
              CommonButton(
                  onPressed: () {},
                  child: "Оформить".w(500).s(13).c(Color(0xFFDFE2E9)))
            ],
          ),
        ),
      ]),
    );
  }
}
