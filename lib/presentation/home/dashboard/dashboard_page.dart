import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/all_view_widget.dart';
import 'package:onlinebozor/presentation/ads/ads_collection%20/cubit/ads_collection_cubit.dart';
import 'package:onlinebozor/presentation/ads/ads_list/cubit/ads_list_cubit.dart';

import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/ads_horizontal_widget.dart';
import '../../../common/widgets/app_bar/common_search_bar.dart';
import '../../../common/widgets/commodity_and_service.dart';
import '../../../common/widgets/popular_category.dart';
import 'cubit/dashboard_cubit.dart';

@RoutePage()
class DashboardPage
    extends BasePage<DashboardCubit, DashboardBuildable, DashboardListenable> {
  const DashboardPage({super.key});

  @override
  Widget builder(BuildContext context, DashboardBuildable state) {
    return Scaffold(
      appBar: CommonSearchBar(
        onPressedMic: () {},
        onPressedNotification: () {
          context.router.push(NotificationRoute());
        },
        onPressedSearch: () {
          context.router.push(SearchRoute());
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppCommodityAndService(
                  onPressed: () {
                    context.router.push(AdsCollectionRoute(
                        CollectiveType: CollectiveType.commodity));
                  },
                  color: Color(0xFFB9A0FF),
                  title: Strings.commodityTitle
                      .w(700)
                      .s(20)
                      .c(context.colors.textPrimaryInverse),
                  endColorGradient: Color(0xFFAFA2DA),
                  image: Assets.images.pngImages.commondity.image(),
                  startColorGradient: Color(0xFF9570FF),
                ),
              ),
              Flexible(
                flex: 1,
                child: AppCommodityAndService(
                  onPressed: () {
                    context.router.push(AdsCollectionRoute(
                        CollectiveType: CollectiveType.service));
                  },
                  color: Color(0xFFFFBB79),
                  title: Strings.serviceTitle
                      .w(700)
                      .s(20)
                      .c(context.colors.textPrimaryInverse),
                  endColorGradient: Color(0xFFF0C49A),
                  image: Assets.images.pngImages.service.image(),
                  startColorGradient: Color(0xFFF7993D),
                ),
              )
            ],
          ),
          AppAllViewWidget(
              onPressed: () {
                // context.router
                //     .push(AdsListRoute(adsListType: AdsListType.hotDiscount));
              },
              title: Strings.popularCategories
                  .w(600)
                  .s(14)
                  .c(context.colors.textPrimary)),
          Divider(height: 1.50, color: Color(0xFFE5E9F3)),
          SizedBox(
            height: 156,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 15,
              padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
              itemBuilder: (context, index) {
                return AppPopularCategory(
                  title: 'Kompyuter'.w(400).s(12),
                  image: Assets.images.pc.image(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 16);
              },
            ),
          ),
          Divider(
            height: 6,
            color: Color(0xFFE5E9F3),
          ),
          AppAllViewWidget(
              onPressed: () {
                context.router
                    .push(AdsListRoute(adsListType: AdsListType.hotDiscount));
              },
              title: Strings.hotDiscountsTitle
                  .w(600)
                  .s(14)
                  .c(context.colors.textPrimary)),
          SizedBox(
            height: 342,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 15,
              padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
              itemBuilder: (context, index) {
                return AppAdsHorizontalWidget(
                  title:
                      "Kitob sotaman  yaqinda olingan, Kitob sotaman  yaqinda olingan "
                          .w(400)
                          .s(10)
                          .c(context.colors.textPrimary)
                          .copyWith(maxLines: 2),
                  price: "20-30 ".w(700).s(10),
                  location: "Namangan viloyat Pop tumani"
                      .w(400)
                      .s(10)
                      .c(context.colors.textSecondary)
                      .copyWith(
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                  adsStatusType: AdsStatusType.standard,
                  adsPropertyType: AdsPropertyType.newly,
                  adsRouteType: AdsRouteType.private,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 16);
              },
            ),
          ),
        ]),
      )),
    );
  }
}
