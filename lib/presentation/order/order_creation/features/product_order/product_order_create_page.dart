import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/common/common_text_field.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../util.dart';
import 'cubit/product_order_create_cubit.dart';

@RoutePage()
class ProductOrderCreatePage extends BasePage<ProductOrderCreateCubit,
    ProductOrderCreateBuildable, ProductOrderCreateListenable> {
  ProductOrderCreatePage({super.key});

  @override
  void listener(BuildContext context, ProductOrderCreateListenable event) {}

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController fromPriceController = TextEditingController();
  final TextEditingController toPriceController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '+998');
  final TextEditingController emailController = TextEditingController();

  @override
  Widget builder(BuildContext context, ProductOrderCreateBuildable state) {
    nameEditingController.text != state.name
        ? nameEditingController.text = state.name ?? ""
        : nameEditingController.text = nameEditingController.text;
    descriptionController.text != state.description
        ? descriptionController.text = state.description ?? ""
        : descriptionController.text = descriptionController.text;
    fromPriceController.text != state.fromPrice
        ? fromPriceController.text = state.fromPrice ?? ""
        : fromPriceController.text = fromPriceController.text;
    toPriceController.text != state.toPrice
        ? toPriceController.text = state.toPrice ?? ""
        : toPriceController.text = toPriceController.text;

    void setSelectionCategory(CategoryResponse categoryResponse) {
      context.read<ProductOrderCreateCubit>().setCategory(categoryResponse);
    }

    void selectionUserAddress(UserAddressResponse userAddressResponse) {
      context
          .read<ProductOrderCreateCubit>()
          .setUserAddress(userAddressResponse);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(physics: BouncingScrollPhysics(), children: [
        Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Название товара".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRequiredField.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            CommonTextField(
                hint: "Название товара",
                onChanged: (value) {
                  context.read<ProductOrderCreateCubit>().setName(value);
                },
                controller: nameEditingController),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Категория".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRequiredField.svg(height: 8, width: 8)
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
                child: InkWell(
                  onTap: () {
                    context.router.push(
                        SelectionCategoryRoute(onResult: (categoryResponse) {
                      setSelectionCategory(categoryResponse);
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (state.categoryResponse?.name ?? "Овощи")
                          .w(400)
                          .s(14)
                          .c(Color(0xFF41455E)),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
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
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(6)),
                      child: Assets.images.icCamera.svg(),
                    )
                  ],
                )),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Описание товара".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRequiredField.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFDFE2E9),
                  border: Border.all(width: 1, color: Color(0xFFDFE2E9))),
              child: Flexible(
                  child: TextFormField(
                      maxLengthEnforcement: MaxLengthEnforcement.none,
                      maxLength: 1000,
                      onChanged: (value) {
                        context
                            .read<ProductOrderCreateCubit>()
                            .setDescription(value);

                        cubit(context).setDescription(value);
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          isDense: false,
                          counter: Offstage(),
                          hintText: 'Write a message',
                          border: InputBorder.none))),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Напишите еще 80 символов".w(500).s(14).c(Color(0xFF9EABBE)),
                "${(state.description ?? "").length}/1000"
                    .toString()
                    .w(500)
                    .s(12)
                    .c(Color(0xFF9EABBE))
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Цена".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRequiredField.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            CommonTextField(
              hint: "От",
              controller: fromPriceController,
              inputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                context.read<ProductOrderCreateCubit>().setFromPrice(value);
              },
            ),
            SizedBox(height: 16),
            CommonTextField(
              hint: "До",
              controller: toPriceController,
              inputType: TextInputType.number,
              onChanged: (value) {
                context.read<ProductOrderCreateCubit>().setToPrice(value);
              },
            ),
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
                    "Uzb".w(400).s(14).c(Color(0xFF41455E)),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoSwitch(
                    value: state.isNegotiate,
                    onChanged: (value) {
                      context
                          .read<ProductOrderCreateCubit>()
                          .setNegative(value);
                    }),
                SizedBox(width: 16),
                "Договорная".w(400).s(16).c(Color(0xFF41455E))
              ],
            ),
            SizedBox(height: 16)
          ]),
        ),
        Divider(height: 10, color: Color(0xFFF6F7FC)),
        Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            "Контактная информация".w(700).s(14).c(Color(0xFF41455E)),
            SizedBox(height: 24),
            "Номер телефона".w(500).s(14).c(Color(0xFF41455E)),
            SizedBox(height: 10),
            CommonTextField(
              inputType: TextInputType.phone,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              controller: phoneController,
              inputFormatters: phoneMaskFormatter,
              onChanged: (value) {
                // context.read<ProductOrderCreateCubit>().setPhone(value);
              },
            ),
            SizedBox(height: 20),
            "Эл. почта".w(500).s(14).c(Color(0xFF41455E)),
            SizedBox(height: 10),
            CommonTextField(
              inputType: TextInputType.emailAddress,
              maxLines: 1,
              controller: emailController,
              onChanged: (value) {
                // context.read<ProductOrderCreateCubit>().setPhone(value);
              },
            ),
            SizedBox(height: 24),
          ]),
        ),
        Divider(height: 10),
        Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            "По какому адресу?".w(700).s(14).c(Color(0xFF41455E)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Моё местоположения".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRequiredField.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 10),
            "Город, улица, дом".w(500).s(14).c(Color(0xFF9EABBE)),
            SizedBox(height: 10),
            Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xFFFAF9FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Color(0xFFDFE2E9))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    context.router.push(SelectionUserAddressRoute(
                        onResult: (userAddressResponse) {
                      selectionUserAddress(userAddressResponse);
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (state.userAddressResponse?.name ??
                              "г. Ташкент, р-н Шайхонтохур, Эшо...")
                          .w(400)
                          .s(14)
                          .c(Color(0xFF41455E)),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Где искать?".w(500).s(14).c(Color(0xFF41455E)),
                SizedBox(width: 5),
                Assets.images.icRequiredField.svg(height: 8, width: 8)
              ],
            ),
            SizedBox(height: 16),
            "Город, улица, дом".w(500).s(14).c(Color(0xFF9EABBE)),
            SizedBox(height: 12),
            Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xFFFAF9FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Color(0xFFDFE2E9))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    context.router.push(SelectionUserAddressRoute(
                        onResult: (userAddressResponse) {
                      selectionUserAddress(userAddressResponse);
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (state.userAddressResponse?.name ??
                              "г. Ташкент, р-н Шайхонтохур, Эшо...")
                          .w(400)
                          .s(14)
                          .c(Color(0xFF41455E)),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
        Container(height: 10, color: Color(0xFFF6F7FC)),
        Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            "Автопродление".w(600).s(14).c(Color(0xFF41455E)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoSwitch(
                    value: state.isNegotiate, onChanged: (value) {}),
                SizedBox(width: 16),
                "Запрос будет деактивировано через 5 дней"
                    .w(400)
                    .s(12)
                    .c(Color(0xFF41455E))
              ],
            ),
            SizedBox(height: 24),
          ]),
        ),
        Container(height: 10, color: Color(0xFFF6F7FC)),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Assets.images.icRequiredField.svg(height: 8, width: 8),
                SizedBox(width: 10),
                Expanded(
                  child: "Необходимо заполнить все поля отмеченный звездочкой  "
                      .w(500)
                      .s(14)
                      .c(Color(0xFF41455E))
                      .copyWith(maxLines: 2),
                )
              ],
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            SizedBox(
                height: 48,
                child: CommonButton(
                    color: Color(0xFFF66512),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.images.icMic
                            .svg(height: 24, width: 24, color: Colors.white),
                        SizedBox(width: 10),
                        "Начать".w(400).s(12).c(Colors.white)
                      ],
                    ))),
          ]),
        ),
      ]),
    );
  }
}
