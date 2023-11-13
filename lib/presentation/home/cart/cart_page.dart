import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/model/ad_enum.dart';

import '../../../common/widgets/common_button.dart';
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
        actions: [
          if (true)
            CommonButton(
                type: ButtonType.text,
                onPressed: () {},
                child: "Выбрать все".w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            6), // Set the desired border radius
                      ),
                    ),
                  ),
                  child: Checkbox(
                    value: state.checkBox,
                    onChanged: (bool? value) {
                      context.read<CartCubit>().checkBoxClick();
                    },
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    color: Color(0xFFF6F7FC),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => Center(),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  )),
              SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    "Leapmotor c11 2022 tayyor nalichida Leapmotor c11 2022 tayyor nalichida"
                        .w(500)
                        .s(14)
                        .c(Color(0xFF41455E))
                        .copyWith(overflow: TextOverflow.ellipsis, maxLines: 2),
                    SizedBox(height: 15),
                    if (7000 != 0)
                      "${formatter.format(500).replaceAll(',', ' ')}-${formatter.format(7000).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                          .w(700)
                          .s(15)
                          .c(Color(0xFF5C6AC3))
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis)
                    else
                      "${formatter.format(8000).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                          .w(700)
                          .s(15)
                          .c(Color(0xFF5C6AC3))
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 12),
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
                                height: 28,
                                width: 28,
                                child: Assets.images.icLike.svg())),
                        SizedBox(width: 8),
                        InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        width: 1, color: Color(0xFFDFE2E9))),
                                height: 28,
                                width: 28,
                                child: Assets.images.icDelete.svg())),
                        Spacer(),
                        Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1, color: Color(0xFFDFE2E9))),
                            child: Row(
                              children: [
                                InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {},
                                    child: Icon(Icons.remove, size: 16)),
                                SizedBox(width: 15),
                                "10".w(600),
                                SizedBox(width: 15),
                                InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {},
                                    child: Icon(Icons.add, size: 16)),
                              ],
                            )),
                        SizedBox(width: 16)
                      ],
                    )
                  ])),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            6), // Set the desired border radius
                      ),
                    ),
                  ),
                  child: Checkbox(
                    value: state.checkBox,
                    onChanged: (bool? value) {
                      context.read<CartCubit>().checkBoxClick();
                    },
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    color: Color(0xFFF6F7FC),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => Center(),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  )),
              SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    "Leapmotor c11 2022 tayyor nalichida Leapmotor c11 2022 tayyor nalichida"
                        .w(500)
                        .s(14)
                        .c(Color(0xFF41455E))
                        .copyWith(overflow: TextOverflow.ellipsis, maxLines: 2),
                    SizedBox(height: 15),
                    if (7000 != 0)
                      "${formatter.format(500).replaceAll(',', ' ')}-${formatter.format(7000).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                          .w(700)
                          .s(15)
                          .c(Color(0xFF5C6AC3))
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis)
                    else
                      "${formatter.format(8000).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                          .w(700)
                          .s(15)
                          .c(Color(0xFF5C6AC3))
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 12),
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
                                height: 28,
                                width: 28,
                                child: Assets.images.icLike.svg())),
                        SizedBox(width: 8),
                        InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        width: 1, color: Color(0xFFDFE2E9))),
                                height: 28,
                                width: 28,
                                child: Assets.images.icDelete.svg())),
                        Spacer(),
                        Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1, color: Color(0xFFDFE2E9))),
                            child: Row(
                              children: [
                                InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {},
                                    child: Icon(Icons.remove, size: 16)),
                                SizedBox(width: 15),
                                "10".w(600),
                                SizedBox(width: 15),
                                InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {},
                                    child: Icon(Icons.add, size: 16)),
                              ],
                            )),
                        SizedBox(width: 16)
                      ],
                    )
                  ])),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            6), // Set the desired border radius
                      ),
                    ),
                  ),
                  child: Checkbox(
                    value: state.checkBox,
                    onChanged: (bool? value) {
                      context.read<CartCubit>().checkBoxClick();
                    },
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    color: Color(0xFFF6F7FC),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => Center(),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  )),
              SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    "Leapmotor c11 2022 tayyor nalichida Leapmotor c11 2022 tayyor nalichida"
                        .w(500)
                        .s(14)
                        .c(Color(0xFF41455E))
                        .copyWith(overflow: TextOverflow.ellipsis, maxLines: 2),
                    SizedBox(height: 15),
                    if (7000 != 0)
                      "${formatter.format(500).replaceAll(',', ' ')}-${formatter.format(7000).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                          .w(700)
                          .s(15)
                          .c(Color(0xFF5C6AC3))
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis)
                    else
                      "${formatter.format(8000).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                          .w(700)
                          .s(15)
                          .c(Color(0xFF5C6AC3))
                          .copyWith(
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 12),
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
                                height: 28,
                                width: 28,
                                child: Assets.images.icLike.svg())),
                        SizedBox(width: 8),
                        InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        width: 1, color: Color(0xFFDFE2E9))),
                                height: 28,
                                width: 28,
                                child: Assets.images.icDelete.svg())),
                        Spacer(),
                        Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1, color: Color(0xFFDFE2E9))),
                            child: Row(
                              children: [
                                InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {},
                                    child: Icon(Icons.remove, size: 16)),
                                SizedBox(width: 15),
                                "10".w(600),
                                SizedBox(width: 15),
                                InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {},
                                    child: Icon(Icons.add, size: 16)),
                              ],
                            )),
                        SizedBox(width: 16)
                      ],
                    )
                  ])),
            ],
          ),
        ),
      ]),
    );
  }
}
