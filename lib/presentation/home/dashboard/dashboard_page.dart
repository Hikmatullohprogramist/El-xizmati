import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/ad_group_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_widget.dart';
import 'package:onlinebozor/common/widgets/all_view_widget.dart';
import 'package:onlinebozor/common/widgets/app_banner_widget.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';

import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/app_bar/common_search_bar.dart';
import '../../../common/widgets/commodity_and_service.dart';
import '../../../common/widgets/common_button.dart';
import '../../../domain/model/ad/ad_response.dart';
import '../../ad/ad_collection/cubit/ad_collection_cubit.dart';
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
                    context.router.push(AdCollectionRoute(
                      collectiveType: CollectiveType.commodity,
                    ));
                  },
                  color: Color(0xFFB9A0FF),
                  title: Strings.commodityTitle,
                  endColorGradient: Color(0xFFAFA2DA),
                  image: Assets.images.pngImages.commondity.image(),
                  startColorGradient: Color(0xFF9570FF),
                ),
              ),
              Flexible(
                flex: 1,
                child: AppCommodityAndService(
                  onPressed: () {
                    context.router.push(AdCollectionRoute(
                        collectiveType: CollectiveType.service));
                  },
                  color: Color(0xFFFFBB79),
                  title: Strings.serviceTitle,
                  endColorGradient: Color(0xFFF0C49A),
                  image: Assets.images.pngImages.service.image(),
                  startColorGradient: Color(0xFFF7993D),
                ),
              )
            ],
          ),
          // AppAllViewWidget(
          //     onPressed: () {
          //       // context.router
          //       //     .push(AdsListRoute(adsListType: AdsListType.hotDiscount));
          //     },
          //     title: Strings.popularCategories),
          // Divider(height: 1.50, color: Color(0xFFE5E9F3)),
          // SizedBox(
          //   height: 156,
          //   child: ListView.separated(
          //     physics: BouncingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //     itemCount: 15,
          //     padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
          //     itemBuilder: (context, index) {
          //       return AppPopularCategory(
          //         title: 'Kompyuter',
          //         image: Assets.images.pc.image(),
          //       );
          //     },
          //     separatorBuilder: (BuildContext context, int index) {
          //       return SizedBox(width: 16);
          //     },
          //   ),
          // ),
          // Divider(
          //   height: 6,
          //   color: Color(0xFFE5E9F3),
          // ),
          AppAllViewWidget(
              onPressed: () {
                context.router.push(AdListRoute(adType: AdType.list));
              },
              title: Strings.hotDiscountsTitle),
          LoaderStateWidget(
              isFullScreen: false,
              loadingState: state.recentlyAdsState,
              child: AdGroupWidget(
                ads: state.recentlyViewerAds,
                onClick: (AdResponse result) {
                  context.router.push(AdDetailRoute());
                },
                onClickFavorite: (AdResponse result) {},
              )),
          LoaderStateWidget(
              isFullScreen: false,
              loadingState: state.bannersState,
              child: AppBannerWidget(list: state.banners)),
          SizedBox(height: 6),
          state.adsPagingController == null
              ? SizedBox()
              : SizedBox(
                  height: 600,
                  child: PagedGridView<int, AdResponse>(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    pagingController: state.adsPagingController!,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 156 / 285,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<AdResponse>(
                      firstPageErrorIndicatorBuilder: (_) {
                        return SizedBox(
                          height: 100,
                          child: Center(
                            child: Column(
                              children: [
                                "Xatolik yuz berdi?"
                                    .w(400)
                                    .s(14)
                                    .c(context.colors.textPrimary),
                                SizedBox(height: 12),
                                CommonButton(
                                    onPressed: () {},
                                    type: ButtonType.elevated,
                                    child: "Qayta urinish".w(400).s(15))
                              ],
                            ),
                          ),
                        );
                      },
                      firstPageProgressIndicatorBuilder: (_) {
                        return SizedBox(
                          height: 160,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (_) {
                        return Center(
                            child: Text("Hech qanday element topilmadi"));
                      },
                      noMoreItemsIndicatorBuilder: (_) {
                        return Center(child: Text("Boshqa Item Yo'q"));
                      },
                      newPageProgressIndicatorBuilder: (_) {
                        return SizedBox(
                          height: 160,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                      newPageErrorIndicatorBuilder: (_) {
                        return SizedBox(
                          height: 160,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                      itemBuilder: (context, item, index) => AppAdWidget(
                        result: item,
                        onClickFavorite: (value) {
                          Logger log = Logger();
                          log.w(value);
                        },
                        onClick: (value) {
                          context.router.push(AdDetailRoute());
                        },
                      ),
                    ),
                  ),
                )
        ]),
      )),
    );
  }
}
