import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../domain/model/ad_enum.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/ad/ad_group_widget.dart';
import '../../../common/widgets/ad/ad_widget.dart';
import '../../../common/widgets/all_view_widget.dart';
import '../../../common/widgets/app_banner_widget.dart';
import '../../../common/widgets/app_bar/common_search_bar.dart';
import '../../../common/widgets/app_diverder.dart';
import '../../../common/widgets/category/popular_category_group.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../common/widgets/root_commodity_and_service.dart';
import '../../../data/model/ads/ad/ad_response.dart';
import '../../../domain/model/ad_model.dart';
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
          onPressedNotification: () => context.router.push(NotificationRoute()),
          onPressedSearch: () => context.router.push(SearchRoute()),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AppRootCommodityAndService(),
                  AppAllViewWidget(
                      onPressed: () =>
                          context.router.push(PopularCategoriesRoute()),
                      title: Strings.popularCategories),
                  LoaderStateWidget(
                      isFullScreen: false,
                      loadingState: state.popularCategoriesState,
                      child: PopularCategoryGroupWidget(
                        popularCategories: state.popularCategories,
                        onClick: (popularCategories) {
                          context.router.push(AdListRoute(
                              adListType: AdListType.popularCategory,
                              keyWord: popularCategories.key_word));
                        },
                      )),
                  AppDivider(height: 3),
                  AppAllViewWidget(
                      onPressed: () {
                        context.router.push(AdListRoute(
                            adListType: AdListType.list, keyWord: ''));
                      },
                      title: Strings.hotDiscountsTitle),
                  LoaderStateWidget(
                      isFullScreen: false,
                      loadingState: state.recentlyAdsState,
                      child: AdGroupWidget(
                        ads: state.recentlyViewerAds,
                        onClick: (AdModel result) {
                          context.router.push(AdDetailRoute(adId: result.id));
                        },
                        onClickFavorite: (AdModel result) {},
                      )),
                  LoaderStateWidget(
                      isFullScreen: false,
                      loadingState: state.bannersState,
                      child: AppBannerWidget(list: state.banners)),
                  SizedBox(height: 24)
                ],
              ),
            ),
            SliverPadding(
                padding: EdgeInsets.symmetric(
              horizontal: 16,
            )),
            state.adsPagingController == null
                ? SizedBox()
                : PagedSliverGrid<int, AdModel>(
                    pagingController: state.adsPagingController!,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 156 / 260,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                      crossAxisCount: 2,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<AdModel>(
                      firstPageErrorIndicatorBuilder: (_) {
                        return SizedBox(
                            height: 60,
                            width: double.infinity,
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
                            )));
                      },
                      firstPageProgressIndicatorBuilder: (_) {
                        return SizedBox(
                          height: 60,
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
                      newPageProgressIndicatorBuilder: (_) {
                        return SizedBox(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                      newPageErrorIndicatorBuilder: (_) {
                        return SizedBox(
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                      itemBuilder: (context, item, index) {
                        if (index % 2 == 1) {
                          return Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: AppAdWidget(
                                result: item,
                                onClickFavorite: (value) {},
                                onClick: (value) => context.router
                                    .push(AdDetailRoute(adId: value.id))),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: AppAdWidget(
                              result: item,
                              onClickFavorite: (value) {},
                              onClick: (value) => context.router
                                  .push(AdDetailRoute(adId: value.id)),
                            ),
                          );
                        }
                      },
                    ))
          ],
        ));
  }
}
