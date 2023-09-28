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
import 'package:onlinebozor/common/widgets/app_diverder.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_group.dart';
import 'package:onlinebozor/common/widgets/loading/loader_state_widget.dart';
import 'package:onlinebozor/common/widgets/root_commodity_and_service.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/app_bar/common_search_bar.dart';
import '../../../common/widgets/common_button.dart';
import '../../../domain/model/ad/ad_response.dart';
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          AppRootCommodityAndService(),
          AppAllViewWidget(
              onPressed: () => context.router.push(PopularCategoriesRoute()),
              title: Strings.popularCategories),
          LoaderStateWidget(
              isFullScreen: false,
              loadingState: state.popularCategoriesState,
              child: PopularCategoryGroupWidget(
                popularCategories: state.popularCategories,
                onClick: (popularCategories) {},
              )),
          AppDivider(),
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
      ),
    );
  }
}
