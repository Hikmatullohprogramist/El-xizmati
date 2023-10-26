import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/enum/AdRouteType.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
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

@RoutePage()
class AdDetailPage
    extends BasePage<AdDetailCubit, AdDetailBuildable, AdDetailListenable> {
  const AdDetailPage(this.adId, {super.key});

  final int adId;

  @override
  void init(BuildContext context) {
    context.read<AdDetailCubit>().setAdId(adId);
  }

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
    var formatter = NumberFormat('###,000');
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
              if (state.adDetailResponse?.photos != null)
                AppImageWidget(
                    images: state.adDetailResponse!.photos!
                        .map((e) =>
                            "${Constants.baseUrlForImage}${e.image}" ?? "")
                        .toList())
              else
                SizedBox(
                  height: 360,
                  width: double.infinity,
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    strokeWidth: 8,
                  )),
                ),
              AppDivider(height: 1),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      (state.adDetailResponse?.name ?? "")
                          .w(600)
                          .s(16)
                          .c(Color(0xFF41455E))
                          .copyWith(
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 21),
                      if (state.adDetailResponse?.price == 0)
                        "${formatter.format(state.adDetailResponse?.to_price).replaceAll(',', ' ')}-${formatter.format(state.adDetailResponse?.from_price).replaceAll(',', ' ')} ${Currency.UZB.getName}"
                            .w(700)
                            .s(20)
                            .c(Color(0xFFFF0098))
                            .copyWith(
                                maxLines: 1, overflow: TextOverflow.ellipsis)
                      else
                        "${formatter.format(state.adDetailResponse?.price).replaceAll(',', ' ')} ${Currency.UZB.getName}"
                            .w(700)
                            .s(20)
                            .c(Color(0xFFFF0098))
                            .copyWith(
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 24),
                      AppDivider(),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          AppAdRouterWidget(
                              isHorizontal: false,
                              adRouteType: AdRouteType.business),
                          SizedBox(width: 5),
                          AppAdPropertyWidget(
                              isHorizontal: false,
                              adsPropertyType: PropertyStatuses.used)
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
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Assets.images.icEye.svg(),
                                    SizedBox(width: 8),
                                    "Просмотров: "
                                        .w(400)
                                        .s(14)
                                        .c(Color(0xFF9EABBE)),
                                    "4798".w(500).s(14).c(Color(0xFF41455E))
                                  ])),
                          SizedBox(width: 8),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0x28AEB2CD)),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Assets.images.icComplain.svg(),
                                    SizedBox(width: 8),
                                    "Пожаловаться"
                                        .w(400)
                                        .s(14)
                                        .c(Color(0xFFF66412))
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
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
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
                          child: "Местоположение"
                              .w(500)
                              .s(16)
                              .c(Color(0xFF41455E))),
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
                          "Ташкентская область"
                              .w(500)
                              .s(12)
                              .c(Color(0xFF9EABBE))
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
                                "Написать сообщение"
                                    .w(500)
                                    .s(16)
                                    .c(Colors.white)
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
        ));
  }
}
