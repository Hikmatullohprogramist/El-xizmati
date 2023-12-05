import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';
import 'package:onlinebozor/presentation/ad/user_ad_detail/cubit/user_ad_detail_cubit.dart';

import '../../../common/constants.dart';
import '../../../common/core/base_page.dart';
import '../../../common/widgets/dashboard/app_image_widget.dart';

@RoutePage()
class UserAdDetailPage extends BasePage<UserAdDetailCubit,
    UserAdDetailBuildable, UserAdDetailListenable> {
  const UserAdDetailPage({super.key});

  @override
  Widget builder(BuildContext context, UserAdDetailBuildable state) {
    return Scaffold(
      appBar: AppBar(
          title: "ID12345677".w(500),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: Assets.images.icArrowLeft.svg(height: 24, width: 24)),
          actions: [
            Padding(
                padding: EdgeInsets.all(4),
                child: IconButton(
                  icon: Assets.images.icMoreVert.svg(height: 24, width: 24),
                  onPressed: () {},
                ))
          ]),
      body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            AppImageWidget(
              images: (List.empty(growable: true))
                  .map((e) => "${Constants.baseUrlForImage}${e.image}")
                  .toList(),
              onClick: (String image) {
                context.router.push(PhotoViewRoute(
                  lists: (List.empty(growable: true))
                      .map((e) => "${Constants.baseUrlForImage}${e.image}")
                      .toList(),
                ));
              },
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: "Электромобиль Volkswagen ID4 Pro Crozz Full"
                  .w(600)
                  .s(14)
                  .c(Color(0xFF41455E))
                  .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                "Остаток:".w(400).s(12).c(Color(0xFF9EABBE)),
                SizedBox(width: 6),
                "2".s(12).c(Color(0xFF41455E)).w(500)
              ]),
            ),
            SizedBox(height: 6),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: "Транспорт - Легковые автомобили"
                    .w(400)
                    .s(12)
                    .c(Color(0xFF9EABBE))
                    .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis)),
            SizedBox(height: 24),
            AppDivider(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                "473 769 560 сум".w(700).s(16).c(Color(0xFF5C6AC3))
              ]),
            ),
            AppDivider(height: 1),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                Assets.images.icCalendar.svg(width: 24, height: 24),
                SizedBox(width: 8),
                "02.02.2023 - 04.03.2023".w(500).s(12).c(Color(0xFF9EABBE)),
              ]),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Assets.images.icLocation.svg(height: 24, width: 24),
                SizedBox(width: 6),
                "Ташкент, Юнусабадский район".w(400).s(12).c(Color(0xFF9EABBE))
              ]),
            ),
            SizedBox(height: 16),
            AppDivider(height: 1),
            Container(
              margin: EdgeInsets.all(16),
              child: CommonButton(
                onPressed: () {},
                child:
                    "Посмотреть статистику".w(500).s(12).c(Color(0xFF41455E)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                          "136".w(600).s(10).c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDADDE5)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.images.icLiked.svg(
                              height: 12,
                              width: 12,
                              color: context.colors.iconGrey),
                          SizedBox(width: 8),
                          "136".w(600).s(10).c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
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
                          "136".w(600).s(10).c(Color(0xFF41455E))
                        ]),
                  ),
                  Container(
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
                          "136".w(600).s(10).c(Color(0xFF41455E))
                        ]),
                  )
                ],
              ),
            ),
            SizedBox(height: 24)
          ]),
    );
  }
}
