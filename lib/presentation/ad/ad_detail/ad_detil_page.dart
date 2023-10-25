import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/favorite_widget.dart';
import 'package:onlinebozor/presentation/ad/ad_detail/cubit/ad_detail_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/widgets/ad/ad_property_widget.dart';
import '../../../common/widgets/ad/ad_route_widget.dart';
import '../../../common/widgets/app_diverder.dart';
import '../../../common/widgets/app_image_widget.dart';
import '../../../common/widgets/common_button.dart';
import '../../../domain/model/ads/ad/ad_response.dart';

@RoutePage()
class AdDetailPage
    extends BasePage<AdDetailCubit, AdDetailBuildable, AdDetailListenable> {
  const AdDetailPage({super.key});

  Widget getWatch(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title.w(500).s(14).c(Color(0xFF41455E)),
          IconButton(
              onPressed: onPressed,
              icon: Assets.images.icArrowRight.svg(height: 24, width: 24))
        ],
      ),
    );
  }

  @override
  Widget builder(BuildContext context, AdDetailBuildable state) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          SizedBox(width: 16),
          "Цена:".w(400).s(12).c(Color(0xFF9EABBE)),
          SizedBox(width: 8),
          "12 541 000".w(800).c(Color(0xFF5C6AC3)).s(16),
          SizedBox(width: 8),
          "UZS".w(500).s(12).c(Color(0xFF9EABBE)),
          Spacer(),
          CommonButton(
              color: context.colors.buttonPrimary,
              type: ButtonType.elevated,
              onPressed: () {},
              child: "В корзину".s(13).c(Colors.white).w(500)),
          SizedBox(width: 16)
        ]),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: Assets.images.icArrowLeft.svg(height: 24, width: 24)),
          actions: [
            Padding(
                padding: EdgeInsets.all(4),
                child: AppFavoriteWidget(isSelected: false, onEvent: () {}))
          ]),
      body: SafeArea(
        bottom: true,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            AppImageWidget(
              images: const [
                "https://api.online-bozor.uz/uploads/images/ff80818197d1375eb6232ea1",
                "https://api.online-bozor.uz/uploads/images/ff80818192f139ea4a6bd505",
                "https://api.online-bozor.uz/uploads/images/ff808181c5e63362532cb295",
                "https://api.online-bozor.uz/uploads/images/ff8081811b383adf10ac97b5",
              ],
            ),
            AppDivider(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    "Опалубка, стойка, леса, арава, Юнусободда, сехоз, уч кахрамон"
                        .w(600)
                        .s(16)
                        .c(Color(0xFF41455E))
                        .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 21),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: "500 y.e"
                            .w(700)
                            .s(20)
                            .c(Color(0xFFFF0098))
                            .copyWith(textAlign: TextAlign.start, maxLines: 1)),
                    SizedBox(height: 24),
                    AppDivider(),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        AppAdRouterWidget(
                            isHorizontal: false,
                            adRouteType: AdRouteType.BUSINESS),
                        SizedBox(width: 5),
                        AppAdPropertyWidget(
                            isHorizontal: false,
                            adsPropertyType: PropertyStatus.USED)
                      ],
                    ),
                    AppDivider(height: 16),
                    SizedBox(height: 16),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0x28AEB2CD)),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              "Опубликовано: "
                                  .w(400)
                                  .s(14)
                                  .c(Color(0xFF9EABBE)),
                              "24 января 2023 г."
                                  .w(500)
                                  .s(14)
                                  .c(Color(0xFF41455E))
                            ]))),
                    SizedBox(height: 8),
                    Align(
                      child: Row(children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0x28AEB2CD)),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Assets.images.icEye.svg(),
                              SizedBox(width: 8),
                              "Просмотров: ".w(400).s(14).c(Color(0xFF9EABBE)),
                              "4798".w(500).s(14).c(Color(0xFF41455E))
                            ])),
                        SizedBox(width: 8),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0x28AEB2CD)),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Assets.images.icComplain.svg(),
                              SizedBox(width: 8),
                              "Пожаловаться".w(400).s(14).c(Color(0xFFF66412))
                            ])),
                      ]),
                    ),
                    SizedBox(height: 8),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0x28AEB2CD)),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              "ID: ".w(400).s(14).c(Color(0xFF9EABBE)),
                              "46109315".w(500).s(14).c(Color(0xFF41455E))
                            ]))),
                    SizedBox(height: 16),
                    AppDivider(height: 1),
                    getWatch("Описание", () {}),
                    "ДИЗАЙН И УПРАВЛЕНИЕ- Комбинированная Тип панели - ГазоваяЦвет - ЧерныйФурнитура - ЧернаяПереключатели - ПоворотныеДисплей - VFT сенсорный дисплейСигнал окончания приготовления - ЕстьОбъем духового шкафа - 115 л..."
                        .w(400)
                        .s(14)
                        .c(Color(0xFF41455E))
                        .copyWith(maxLines: 6),
                    SizedBox(height: 16),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: "Показать больше"
                            .w(500)
                            .s(14)
                            .c(Color(0xFF5C6AC3))),
                    SizedBox(height: 24),
                    AppDivider(),
                    getWatch("Характеристики", () {}),
                    AppDivider(),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "Продавец".w(500).s(16).c(Color(0xFF41455E)),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          height: 52,
                          width: 52,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFE0E0ED),
                              borderRadius: BorderRadius.circular(10)),
                          child: Assets.images.icAvatarBoy.svg(),
                        ),
                        SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Valixaitov759759"
                                .w(600)
                                .s(16)
                                .c(Color(0xFF41455E))
                                .copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                "на OnlineBozor с"
                                    .w(500)
                                    .s(14)
                                    .c(Color(0xFF9EABBE)),
                                " январь 2023г."
                                    .w(400)
                                    .s(14)
                                    .c(Color(0xFF41455E))
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Assets.images.icArrowRight
                                .svg(width: 24, height: 24)),
                      ],
                    ),
                    SizedBox(height: 24),
                    Align(
                        alignment: Alignment.centerLeft,
                        child:
                            "Местоположение".w(500).s(16).c(Color(0xFF41455E))),
                    Row(
                      children: [
                        Assets.images.icLocation.svg(width: 16, height: 16),
                        SizedBox(width: 4),
                        TextButton(
                            onPressed: () {
                              launchUrl(
                                Uri.parse("geo:41.311150,69.279739"),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: "Ташкент, Сергелийский район"
                                .w(700)
                                .s(12)
                                .c(Color(0xFF5C6AC3)))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 28),
                        "Ташкентская область".w(500).s(12).c(Color(0xFF9EABBE))
                      ],
                    ),
                    SizedBox(height: 16),
                    InkWell(
                        child: Card(
                          color: Color(0xFFFAF9FF),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: Color(0x196B7194),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 24),
                            child: Row(children: [
                              Assets.images.icSms.svg(height: 24, width: 24),
                              SizedBox(width: 16),
                              "Написать сообщение"
                                  .w(500)
                                  .s(16)
                                  .c(Color(0xFF41455E))
                            ]),
                          ),
                        ),
                        onTap: () {
                          launch("sms://+998975705616");
                        }),
                    SizedBox(height: 16),
                    InkWell(
                        child: Card(
                          color: Color(0xFF32B88B),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: Color(0xFF32B88B),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 24),
                            child: Row(children: [
                              Assets.images.icCall.svg(height: 24, width: 24),
                              SizedBox(width: 16),
                              "Написать сообщение".w(500).s(16).c(Colors.white)
                            ]),
                          ),
                        ),
                        onTap: () {
                          launch("tel://+998975705616");
                        }),
                    SizedBox(height: 12),
                    AppDivider(),
                    getWatch("Отзывы ", () {}),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
