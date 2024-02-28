import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';

import '../../../../../../common/constants.dart';
import '../../../../../../common/core/base_page.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../common/widgets/dashboard/app_image_widget.dart';
import 'cubit/order_create_cubit.dart';

@RoutePage()
class OrderCreatePage extends BasePage<PageCubit, PageState,
    PageEvent> {
  const OrderCreatePage(this.adId, {super.key});

  final int adId;

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.delete:
        context.router.push(CartRoute());
      case PageEventType.back:
        context.router.push(CartRoute());
      case PageEventType.navigationAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  void onWidgetCreated(BuildContext context) {
    context.read<PageCubit>().setAdId(adId);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    var formatter = NumberFormat('###,000');
    Widget liked(bool isLiked) {
      if (isLiked) {
        return Assets.images.icFavoriteRemove.svg(color: Colors.red);
      } else {
        return Assets.images.icFavoriteAdd.svg();
      }
    }

    if (state.adDetail != null) {
      return Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(children: [
              SizedBox(width: 16),
              Strings.priceTwoDot.w(400).s(12).c(Color(0xFF9EABBE)),
              SizedBox(width: 8),
              "${formatter.format(state.adDetail!.price * state.count).replaceAll(',', ' ')} ${state.adDetail!.currency.getName}"
                  .w(800)
                  .s(16)
                  .c(Color(0xFF5C6AC3))
                  .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
              Spacer(),
              CommonButton(
                  color: context.colors.buttonPrimary,
                  type: ButtonType.elevated,
                  onPressed: () {
                    context.read<PageCubit>().orderCreate();
                  },
                  child:
                      Strings.orderCreateRegister.s(13).c(Colors.white).w(500)),
              SizedBox(width: 16)
            ]),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: state.adDetail?.adName
                .w(500)
                .s(14)
                .c(context.colors.textPrimary),
            centerTitle: true,
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
          ),
          body: SafeArea(
            bottom: true,
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                AppImageWidget(
                  images: (state.adDetail?.photos ?? List.empty(growable: true))
                      .map((e) => "${Constants.baseUrlForImage}${e.image}")
                      .toList(),
                  onClicked: (int position) {
                    context.router.push(
                      ImageViewerRoute(
                        images: cubit(context).getImages(),
                        initialIndex: position,
                      ),
                    );
                  },
                ),
                AppDivider(height: 1),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        (state.adDetail?.adName ?? "")
                            .w(600)
                            .s(16)
                            .c(Color(0xFF41455E))
                            .copyWith(
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Strings.orderCreateAddress
                                .w(500)
                                .s(14)
                                .c(Color(0xFF9EABBE)),
                            SizedBox(width: 4),
                            Expanded(
                                child: (state.adDetail?.address?.name ?? "")
                                    .w(500)
                                    .s(14)
                                    .c(Color(0xFF41455E))
                                    .copyWith(overflow: TextOverflow.ellipsis))
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Strings.orderCreateCategory
                                .w(500)
                                .s(14)
                                .c(Color(0xFF9EABBE)),
                            SizedBox(width: 4),
                            Expanded(
                                child: (state.adDetail?.categoryName ?? "")
                                    .w(500)
                                    .s(14)
                                    .c(Color(0xFF41455E))
                                    .copyWith(overflow: TextOverflow.ellipsis))
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Strings.orderCreatePrice
                                .w(500)
                                .s(14)
                                .c(Color(0xFF9EABBE)),
                            SizedBox(width: 4),
                            if (state.adDetail?.price == 0)
                              "${formatter.format(state.adDetail?.toPrice).replaceAll(',', ' ')}-"
                                      "${formatter.format(state.adDetail?.fromPrice).replaceAll(',', ' ')} ${state.adDetail?.currency.getName}"
                                  .w(600)
                                  .s(20)
                                  .c(Color(0xFFFF0098))
                                  .copyWith(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis)
                            else
                              "${formatter.format(state.adDetail?.price).replaceAll(',', ' ')} ${state.adDetail?.currency.getName}"
                                  .w(600)
                                  .s(20)
                                  .c(Color(0xFFFF0098))
                                  .copyWith(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        SizedBox(height: 32),
                        Row(
                          children: [
                            InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: () {
                                  context
                                      .read<PageCubit>()
                                      .addFavorite();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xFFDFE2E9))),
                                    height: 44,
                                    width: 44,
                                    child: liked(state.favorite))),
                            SizedBox(width: 16),
                            InkWell(
                                onTap: () {
                                  context.read<PageCubit>().removeCart();
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(0xFFDFE2E9))),
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
                                        onTap: () {
                                          context
                                              .read<PageCubit>()
                                              .minus();
                                        },
                                        child: Icon(Icons.remove, size: 20)),
                                    SizedBox(width: 15),
                                    state.count.toString().w(600),
                                    SizedBox(width: 15),
                                    InkWell(
                                        borderRadius: BorderRadius.circular(6),
                                        onTap: () {
                                          context
                                              .read<PageCubit>()
                                              .add();
                                        },
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
                        Strings.orderCreatePaymentMethod
                            .w(700)
                            .s(16)
                            .c(Color(0xFF41455E)),
                        SizedBox(height: 20),
                        Visibility(
                            visible: state.paymentType.isNotEmpty,
                            child: InkWell(
                                onTap: () {
                                  context
                                      .read<PageCubit>()
                                      .setPaymentType(6);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Color(0xFFDEE1E8))),
                                  child: Row(children: [
                                    if (state.paymentId == 6)
                                      Assets.images.icRadioButtonSelected.svg()
                                    else
                                      Assets.images.icRadioButtonUnSelected
                                          .svg(),
                                    SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Strings.orderCreateOnlinePayment
                                            .w(600)
                                            .c(Color(0xFF41455E))
                                            .s(14),
                                        SizedBox(height: 4),
                                        Strings.orderCreateOnlineDescription
                                            .w(400)
                                            .s(12)
                                            .c(Color(0xFF9EABBE))
                                            .copyWith(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis)
                                      ],
                                    ))
                                  ]),
                                ))),
                        SizedBox(height: 8),
                        Visibility(
                            visible: state.paymentType.isNotEmpty,
                            child: InkWell(
                                onTap: () {
                                  context
                                      .read<PageCubit>()
                                      .setPaymentType(1);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Color(0xFFDEE1E8))),
                                  child: Row(children: [
                                    if (state.paymentId == 1)
                                      Assets.images.icRadioButtonSelected.svg()
                                    else
                                      Assets.images.icRadioButtonUnSelected
                                          .svg(),
                                    SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Strings.orderCreateCashPayment
                                            .w(600)
                                            .c(Color(0xFF41455E))
                                            .s(14),
                                        SizedBox(height: 4),
                                        Strings.orderCreateCashDescription
                                            .w(400)
                                            .s(12)
                                            .c(Color(0xFF9EABBE))
                                            .copyWith(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis)
                                      ],
                                    ))
                                  ]),
                                ))),
                        SizedBox(height: 8),
                        Visibility(
                            visible: state.paymentType.isNotEmpty,
                            child: InkWell(
                                onTap: () {
                                  context
                                      .read<PageCubit>()
                                      .setPaymentType(4);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Color(0xFFDEE1E8))),
                                  child: Row(children: [
                                    if (state.paymentId == 4)
                                      Assets.images.icRadioButtonSelected.svg()
                                    else
                                      Assets.images.icRadioButtonUnSelected
                                          .svg(),
                                    SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Strings.orderCreateTerminalPayment
                                            .w(600)
                                            .c(Color(0xFF41455E))
                                            .s(14),
                                        SizedBox(height: 4),
                                        Strings.orderCreateTerminalDescription
                                            .w(400)
                                            .s(12)
                                            .c(Color(0xFF9EABBE))
                                            .copyWith(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis)
                                      ],
                                    ))
                                  ]),
                                ))),
                        SizedBox(height: 8),
                        Visibility(
                            visible: state.paymentType.isNotEmpty,
                            child: InkWell(
                                onTap: () {
                                  context
                                      .read<PageCubit>()
                                      .setPaymentType(5);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Color(0xFFDEE1E8))),
                                  child: Row(children: [
                                    if (state.paymentId == 5)
                                      Assets.images.icRadioButtonSelected.svg()
                                    else
                                      Assets.images.icRadioButtonUnSelected
                                          .svg(),
                                    SizedBox(width: 16),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Strings.orderCreateTransferPayment
                                            .w(600)
                                            .c(Color(0xFF41455E))
                                            .s(14),
                                        SizedBox(height: 5),
                                        Strings.orderCreateTransferDiscription
                                            .w(400)
                                            .s(12)
                                            .c(Color(0xFF9EABBE))
                                            .copyWith(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis)
                                      ],
                                    ))
                                  ]),
                                ))),
                        // SizedBox(height: 8),
                        // Container(
                        //   padding: EdgeInsets.all(16),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(
                        //           width: 1, color: Color(0xFFDEE1E8))),
                        //   child: Row(children: [
                        //     Assets.images.icRadioButtonSelected
                        //         .svg(),
                        //     SizedBox(width: 16),
                        //     Expanded(
                        //         child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         "Наличними".w(600).c(Color(0xFF41455E)).s(14),
                        //         SizedBox(height: 4),
                        //         "Оплата принимается в узбекских сумах при получении товара."
                        //             .w(400)
                        //             .s(12)
                        //             .c(Color(0xFF9EABBE))
                        //             .copyWith(
                        //                 maxLines: 2,
                        //                 overflow: TextOverflow.ellipsis)
                        //       ],
                        //     ))
                        //   ]),
                        // ),
                        // SizedBox(height: 8),
                        // Container(
                        //   padding: EdgeInsets.all(16),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(
                        //           width: 1, color: Color(0xFFDEE1E8))),
                        //   child: Row(children: [
                        //     Assets.images.icRadioButtonSelected
                        //         .svg(),
                        //     SizedBox(width: 16),
                        //     Expanded(
                        //         child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         "Наличними".w(600).c(Color(0xFF41455E)).s(14),
                        //         SizedBox(height: 4),
                        //         "Оплата принимается в узбекских сумах при получении товара."
                        //             .w(400)
                        //             .s(12)
                        //             .c(Color(0xFF9EABBE))
                        //             .copyWith(
                        //                 maxLines: 2,
                        //                 overflow: TextOverflow.ellipsis)
                        //       ],
                        //     ))
                        //   ]),
                        // ),
                        // SizedBox(height: 8),
                        // Container(
                        //   padding: EdgeInsets.all(16),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(
                        //           width: 1, color: Color(0xFFDEE1E8))),
                        //   child: Row(children: [
                        //     Assets.images.icRadioButtonSelected
                        //         .svg(),
                        //     SizedBox(width: 16),
                        //     Expanded(
                        //         child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         "Наличними".w(600).c(Color(0xFF41455E)).s(14),
                        //         SizedBox(height: 4),
                        //         "Оплата принимается в узбекских сумах при получении товара."
                        //             .w(400)
                        //             .s(12)
                        //             .c(Color(0xFF9EABBE))
                        //             .copyWith(
                        //                 maxLines: 2,
                        //                 overflow: TextOverflow.ellipsis)
                        //       ],
                        //     ))
                        //   ]),
                        // ),
                        // SizedBox(height: 8),
                        // SizedBox(height: 24),
                        // "Тип доставки".w(700).s(20).c(Color(0xFF41455E)),
                        // SizedBox(height: 16),
                        // "Самовывоз".w(600).s(16).c(Color(0xFF41455E)),
                        // SizedBox(height: 12),
                        // "Адрес склада: ".w(500).s(14).c(Color(0xFF9EABBE)),
                        // SizedBox(height: 8),
                        // (state.adDetail?.address?.name ?? "")
                        //     .w(500)
                        //     .s(14)
                        //     .c(Color(0xFF41455E)),
                        // SizedBox(height: 32),
                        // SizedBox(
                        //   height: 42,
                        //   width: double.infinity,
                        //   child: CommonButton(
                        //     type: ButtonType.elevated,
                        //     onPressed: () {
                        //       try {
                        //         launchUrl(
                        //           Uri.parse(state.adDetail?.address?.geo ?? ""),
                        //           mode: LaunchMode.externalApplication,
                        //         );
                        //       } catch (e) {}
                        //     },
                        //     child: "Показать на карте"
                        //         .w(500)
                        //         .s(14)
                        //         .c(Colors.white),
                        //   ),
                        // ),
                        // SizedBox(height: 16),
                        // SizedBox(
                        //   height: 42,
                        //   width: double.infinity,
                        //   child: CommonButton(
                        //       type: ButtonType.outlined,
                        //       onPressed: () {},
                        //       child: "Отправить локацию на телеграм"
                        //           .w(500)
                        //           .c(Color(0xFF5C6AC3))
                        //           .s(14)),
                        // )
                      ],
                    )),
                // SizedBox(height: 8),
                // AppDivider(height: 5, color: Color(0xFFF2F3FA)),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                //   child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         "Доставка".w(600).s(14).c(Color(0xFF41455E)),
                //         SizedBox(height: 14),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             "Своя".w(400).s(14).c(Color(0xFF9EABBE)),
                //             "Бесплатно".w(700).s(12).c(Color(0xFF32B88B))
                //           ],
                //         ),
                //         SizedBox(height: 10),
                //         "Только по городу: Ташкент"
                //             .w(400)
                //             .s(14)
                //             .c(Color(0xFF41455E)),
                //         SizedBox(height: 24),
                //         "Ваши заказы".w(600).s(14).c(Color(0xFF41455E)),
                //         SizedBox(height: 14),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             "Товары: (${state.count})"
                //                 .w(400)
                //                 .s(12)
                //                 .c(Color(0xFF41455E)),
                //             "${formatter.format(state.adDetail!.price * state.count).replaceAll(',', ' ')} ${state.adDetail!.currency.getName}"
                //                 .w(800)
                //                 .s(16)
                //                 .c(Color(0xFF5C6AC3))
                //                 .copyWith(
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis),
                //           ],
                //         ),
                //         SizedBox(height: 5),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             "Итого:".w(400).s(12).c(Color(0xFF41455E)),
                //             "${formatter.format(state.adDetail!.price * state.count).replaceAll(',', ' ')} ${state.adDetail!.currency.getName}"
                //                 .w(800)
                //                 .s(16)
                //                 .c(Color(0xFF5C6AC3))
                //                 .copyWith(
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis),
                //           ],
                //         ),
                //         SizedBox(height: 24),
                //         "*Окончательная стоимость будет рассчитана после выбора способа доставки при оформлении заказа."
                //             .w(400)
                //             .c(Color(0xFF9EABBE))
                //             .s(10)
                //             .copyWith(
                //                 maxLines: 2,
                //                 overflow: TextOverflow.ellipsis,
                //                 textAlign: TextAlign.center)
                //       ]),
                // )
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
                onPressed: () => context.router.pop(),
                icon: Assets.images.icArrowLeft.svg(height: 24, width: 24))),
        body: Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.red,
          strokeWidth: 8,
        )),
      );
    }
  }
}
