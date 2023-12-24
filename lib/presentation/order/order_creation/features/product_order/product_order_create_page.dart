import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/common/common_text_field.dart';

import '../../../../../common/core/base_page.dart';
import 'cubit/product_order_create_cubit.dart';

@RoutePage()
class ProductOrderCreatePage extends BasePage<ProductOrderCreateCubit,
    ProductOrderCreateBuildable, ProductOrderCreateListenable> {
  const ProductOrderCreatePage({super.key});

  @override
  Widget builder(BuildContext context, ProductOrderCreateBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(physics: BouncingScrollPhysics(),
          children: [
        Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Название товара".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icSnow.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            CommonTextField(hint: "5 тонна черрй помидор сотиб оламан", ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Категория".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icSnow.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xFFFAF9FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Color(0xFFDFE2E9))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Овощи".w(400).s(14).c(Color(0xFF41455E)),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            "Фото".w(500).s(14).c(Color(0xFF41455E)),
            SizedBox(
                height: 80,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6)))
                  ],
                )),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Описание товара".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icSnow.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFDFE2E9),
                  border: Border.all(width: 1, color: Color(0xFFDFE2E9))),
              child: TextFormField(),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Напишите еще 80 символов".w(500).s(14).c(Color(0xFF9EABBE)),
                "0 / 9000".w(500).s(12).c(Color(0xFF9EABBE))
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Цена".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icSnow.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            CommonTextField(hint: "От"),
            SizedBox(height: 16),
            CommonTextField(hint: "До"),
            SizedBox(height: 24),
            "Валюта".w(500).s(14).c(Color(0xFF41455E)),
            SizedBox(height: 10),
            Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xFFFAF9FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Color(0xFFDFE2E9))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Овощи".w(400).s(14).c(Color(0xFF41455E)),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoSwitch(value: false, onChanged: (value){}),
                SizedBox(width: 16),
                "Договорная".w(400).s(16).c(Color(0xFF41455E))
              ],
            ),SizedBox(height: 16)
          ]),
        )
      ]),
    );
  }
}
