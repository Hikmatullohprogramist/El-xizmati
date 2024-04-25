import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/detail/detail_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/common/widgets/image/rectangle_cached_network_image_widget.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/presentation/ad/user_ad_detail/cubit/page_cubit.dart';

import '../../../common/core/base_page.dart';
import '../../../domain/models/ad/user_ad.dart';

@RoutePage()
class UserAdDetailPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserAdDetailPage({super.key, required this.userAd});

  final UserAd userAd;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(userAd);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "",
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundColor,
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20),
          _buildImageList(context, state),
          SizedBox(height: 16),
          _buildTitleBlock(context, state),
          SizedBox(height: 16),
          _buildPriceBlock(context, state),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _buildImageList(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: cubit(context).getAdImages().length,
          padding: EdgeInsets.only(left: 10, right: 16),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.router.push(
                  ImageViewerRoute(
                    images: cubit(context).getAdImages(),
                    initialIndex: index,
                  ),
                );
              },
              child: RectangleCachedNetworkImage(
                imageId: cubit(context).getAdImages()[index],
                imageWidth: 160,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10);
          },
        ),
      ),
    );
  }

  Widget _buildTitleBlock(BuildContext context, PageState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          (userAd.name ?? "").w(600).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Strings.userAdDetailRemainder.w(400).s(12).c(Color(0xFF9EABBE)),
                SizedBox(width: 6),
                "0".s(12).c(Color(0xFF41455E)).w(500)
              ],
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: "Транспорт -"
                .w(400)
                .s(12)
                .c(Color(0xFF9EABBE))
                .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
          SizedBox(height: 24),
          CustomDivider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DetailPriceTextWidget(
                  price: userAd.price ?? 0,
                  toPrice: userAd.toPrice ?? 0,
                  fromPrice: userAd.fromPrice ?? 0,
                  currency: userAd.currency.toCurrency(),
                ),
                // "473 769 560 сум".w(700).s(16).c(Color(0xFF5C6AC3))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBlock(BuildContext context, PageState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Assets.images.icCalendar.svg(width: 24, height: 24),
              SizedBox(width: 8),
              ("${userAd.beginDate ?? ""}-${userAd.endDate ?? ""}")
                  .w(500)
                  .s(12)
                  .c(Color(0xFF9EABBE)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Assets.images.icLocation.svg(height: 24, width: 24),
              SizedBox(width: 6),
              ("${userAd.region ?? " "} ${userAd.district ?? ""}")
                  .w(400)
                  .s(12)
                  .c(Color(0xFF9EABBE))
            ],
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.all(16),
            child: CustomElevatedButton(
              text: "Посмотреть статистику",
              onPressed: () {},
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
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
                        (userAd.viewedCount ?? 0)
                            .toString()
                            .w(600)
                            .s(10)
                            .c(Color(0xFF41455E))
                      ]),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: Container(
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
                      (userAd.selectedCount ?? 0)
                          .toString()
                          .w(600)
                          .s(10)
                          .c(Color(0xFF41455E))
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: Container(
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
                        (userAd.phoneViewedCount ?? 0)
                            .toString()
                            .w(600)
                            .s(10)
                            .c(Color(0xFF41455E))
                      ]),
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                flex: 1,
                child: Container(
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
                      (userAd.messageViewedCount ?? 0)
                          .toString()
                          .w(600)
                          .s(10)
                          .c(Color(0xFF41455E))
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
