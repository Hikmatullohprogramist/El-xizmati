import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/presentation/home/cart/features%20/order_create/cubit/order_create_cubit.dart';

import '../../../../../common/constants.dart';
import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/app_diverder.dart';
import '../../../../../common/widgets/app_image_widget.dart';

@RoutePage()
class OrderCreatePage extends BasePage<OrderCreateCubit, OrderCreateBuildable,
    OrderCreateListenable> {
  const OrderCreatePage({super.key});

  @override
  Widget builder(BuildContext context, OrderCreateBuildable state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: "LadaUz_Agent".w(500).s(14).c(context.colors.textPrimary),
          centerTitle: true,
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
          elevation: 0.5,
          // actions: [
          //   if (true)
          //     CommonButton(
          //         type: ButtonType.text,
          //         onPressed: () {},
          //         child: "Выбрать все".w(500).s(12).c(Color(0xFF5C6AC3)))
          // ],
        ),
        body: SafeArea(
          bottom: true,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              AppImageWidget(
                  images: List.empty(growable: true)
                      .map(
                          (e) => "${Constants.baseUrlForImage}${e.image}" ?? "")
                      .toList()),
              AppDivider(height: 1),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 24),
                      "Лада Веста Lada Vesta"
                          .w(600)
                          .s(16)
                          .c(Color(0xFF41455E))
                          .copyWith(
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          "Цвет:".w(500).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(width: 4),
                          "Желтый".w(500).s(14).c(Color(0xFF41455E))
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          "Доставка:".w(500).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(width: 4),
                          "Самовывоз".w(500).s(14).c(Color(0xFF41455E))
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          "Цена:".w(500).s(14).c(Color(0xFF9EABBE)),
                          SizedBox(width: 4),
                          "170 013 000 сум".w(500).s(14).c(Color(0xFF41455E))
                        ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 1, color: Color(0xFFDFE2E9))),
                                  height: 44,
                                  width: 44,
                                  child: Assets.images.icLike.svg())),
                          SizedBox(width: 16),
                          InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          width: 1, color: Color(0xFFDFE2E9))),
                                  height: 44,
                                  width: 44,
                                  child: Assets.images.icDelete.svg())),
                          SizedBox(width: 16),
                          Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      width: 1, color: Color(0xFFDFE2E9))),
                              child: Row(
                                children: [
                                  InkWell(
                                      borderRadius: BorderRadius.circular(6),
                                      onTap: () {},
                                      child: Icon(Icons.remove, size: 20)),
                                  SizedBox(width: 15),
                                  "10".w(600),
                                  SizedBox(width: 15),
                                  InkWell(
                                      borderRadius: BorderRadius.circular(6),
                                      onTap: () {},
                                      child: Icon(Icons.add, size: 20)),
                                ],
                              )),
                          SizedBox(width: 16)
                        ],
                      ),
                      SizedBox(height: 24)
                    ],
                  )),
              AppDivider(height: 2, color: Color(0xFFF2F3FA)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Способ оплаты".w(700).s(16).c(Color(0xFF41455E)),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Color(0xFFDEE1E8))),
                        child: Row(children: [
                          Assets.images.profileViewer.icRadioButtonSelected
                              .svg(),
                          SizedBox(width: 16),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Наличними".w(600).c(Color(0xFF41455E)).s(14),
                              SizedBox(height: 4),
                              "Оплата принимается в узбекских сумах при получении товара."
                                  .w(400)
                                  .s(12)
                                  .c(Color(0xFF9EABBE))
                                  .copyWith(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)
                            ],
                          ))
                        ]),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Color(0xFFDEE1E8))),
                        child: Row(children: [
                          Assets.images.profileViewer.icRadioButtonSelected
                              .svg(),
                          SizedBox(width: 16),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Наличними".w(600).c(Color(0xFF41455E)).s(14),
                              SizedBox(height: 4),
                              "Оплата принимается в узбекских сумах при получении товара."
                                  .w(400)
                                  .s(12)
                                  .c(Color(0xFF9EABBE))
                                  .copyWith(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)
                            ],
                          ))
                        ]),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Color(0xFFDEE1E8))),
                        child: Row(children: [
                          Assets.images.profileViewer.icRadioButtonSelected
                              .svg(),
                          SizedBox(width: 16),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Наличними".w(600).c(Color(0xFF41455E)).s(14),
                              SizedBox(height: 4),
                              "Оплата принимается в узбекских сумах при получении товара."
                                  .w(400)
                                  .s(12)
                                  .c(Color(0xFF9EABBE))
                                  .copyWith(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)
                            ],
                          ))
                        ]),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: Color(0xFFDEE1E8))),
                        child: Row(children: [
                          Assets.images.profileViewer.icRadioButtonSelected
                              .svg(),
                          SizedBox(width: 16),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Наличними".w(600).c(Color(0xFF41455E)).s(14),
                              SizedBox(height: 4),
                              "Оплата принимается в узбекских сумах при получении товара."
                                  .w(400)
                                  .s(12)
                                  .c(Color(0xFF9EABBE))
                                  .copyWith(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)
                            ],
                          ))
                        ]),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 24),
                      "Тип доставки".w(700).s(20).c(Color(0xFF41455E)),
                      SizedBox(height: 16),
                      "Самовывоз".w(600).s(16).c(Color(0xFF41455E)),
                      SizedBox(height: 12),
                      "Адрес склада: ".w(500).s(14).c(Color(0xFF9EABBE)),
                      SizedBox(height: 8),
                      "Ташкент, Юнусабадский район, Amur Temur shox 107B"
                          .w(500)
                          .s(14)
                          .c(Color(0xFF41455E)),
                      SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: CommonButton(
                          type: ButtonType.elevated,
                          onPressed: () {},
                          child:
                              "Показать на карте".w(500).s(14).c(Colors.white),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CommonButton(
                            type: ButtonType.outlined,
                            onPressed: () {},
                            child: "Отправить локацию на телеграм"
                                .w(500)
                                .c(Color(0xFF5C6AC3))
                                .s(14)),
                      )
                    ],
                  )),
              AppDivider(height: 5, color: Color(0xFFF2F3FA)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Доставка".w(600).s(14).c(Color(0xFF41455E)),
                      SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Своя".w(400).s(14).c(Color(0xFF9EABBE)),
                          "Бесплатно".w(700).s(12).c(Color(0xFF32B88B))
                        ],
                      ),
                      SizedBox(height: 10),
                      "Только по городу: Ташкент"
                          .w(400)
                          .s(14)
                          .c(Color(0xFF41455E)),
                      SizedBox(height: 24),
                      "Ваши заказы".w(600).s(14).c(Color(0xFF41455E)),
                      SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Товары: (1)".w(400).s(12).c(Color(0xFF41455E)),
                          "170 013 000 сум".w(700).s(12).c(Color(0xFF5C6AC3))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Итого:".w(400).s(12).c(Color(0xFF41455E)),
                          "170 013 000 сум".w(700).s(12).c(Color(0xFF5C6AC3))
                        ],
                      ),
                      SizedBox(height: 24),
                      "*Окончательная стоимость будет рассчитана после выбора способа доставки при оформлении заказа."
                          .w(400)
                          .c(Color(0xFF9EABBE))
                          .s(10)
                          .copyWith(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center)
                    ]),
              )
            ],
          ),
        ));
  }
}
