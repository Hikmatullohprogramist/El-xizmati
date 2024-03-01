import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/detail_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';
import 'package:onlinebozor/presentation/ad/user_ad_detail/cubit/page_cubit.dart';

import '../../../common/constants.dart';
import '../../../common/core/base_page.dart';
import '../../../common/widgets/dashboard/app_image_widget.dart';

@RoutePage()
class UserAdDetailPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserAdDetailPage({super.key, required this.userAdResponse});

  final UserAdResponse userAdResponse;

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar("", () => context.router.pop()),
      body: Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            AppImageWidget(
              images: ([userAdResponse.main_photo])
                  .map((e) => "${Constants.baseUrlForImage}$e")
                  .toList(),
              onClicked: (int position) {
                context.router.push(
                  ImageViewerRoute(
                    images: (List.empty(growable: true))
                        .map((e) => "${Constants.baseUrlForImage}${e.image}")
                        .toList(),
                    initialIndex: position,
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: (userAdResponse.name ?? "")
                  .w(600)
                  .s(14)
                  .c(Color(0xFF41455E))
                  .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Strings.userAdDetailRemainder.w(400).s(12).c(Color(0xFF9EABBE)),
                SizedBox(width: 6),
                "0".s(12).c(Color(0xFF41455E)).w(500)
              ]),
            ),
            SizedBox(height: 6),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: "Транспорт -"
                    .w(400)
                    .s(12)
                    .c(Color(0xFF9EABBE))
                    .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis)),
            SizedBox(height: 24),
            CustomDivider(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                DetailPriceTextWidget(
                  price: userAdResponse.price ?? 0,
                  toPrice: userAdResponse.to_price ?? 0,
                  fromPrice: userAdResponse.from_price ?? 0,
                  currency: userAdResponse.currency.toCurrency(),
                ),
                // "473 769 560 сум".w(700).s(16).c(Color(0xFF5C6AC3))
              ]),
            ),
            CustomDivider(height: 1),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Assets.images.icCalendar.svg(width: 24, height: 24),
                  SizedBox(width: 8),
                  ("${userAdResponse.begin_date ?? ""}-${userAdResponse.end_date ?? ""}")
                      .w(500)
                      .s(12)
                      .c(Color(0xFF9EABBE)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Assets.images.icLocation.svg(height: 24, width: 24),
                  SizedBox(width: 6),
                  ("${userAdResponse.region ?? " "} ${userAdResponse.district ?? ""}")
                      .w(400)
                      .s(12)
                      .c(Color(0xFF9EABBE))
                ],
              ),
            ),
            SizedBox(height: 16),
            // AppDivider(height: 1),
            // Container(
            //   margin: EdgeInsets.all(16),
            //   child: CommonButton(
            //     type: ButtonType.outlined,
            //     onPressed: () {},
            //     child:
            //         "Посмотреть статистику".w(500).s(12).c(Color(0xFF41455E)),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icEye.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (userAdResponse.view ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icFavoriteRemove.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (userAdResponse.selected ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icCall.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (userAdResponse.phone_view ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icSms.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          (userAdResponse.message_number ?? 0)
                              .toString()
                              .w(600)
                              .s(10)
                              .c(Color(0xFF41455E))
                        ]),
                  )
                ],
              ),
            ),
            SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}
