import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/ad/horizontal/horizontal_ad_list_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/ad/horizontal/horizontal_ad_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/vertical/vertical_ad_widget.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/search_app_bar_2.dart';
import 'package:onlinebozor/presentation/widgets/dashboard/see_all_widget.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'ad_list_by_type_cubit.dart';

@RoutePage()
class AdListByTypePage extends BasePage<AdListByTypeCubit, AdListByTypeState, AdListByTypeEvent> {
  const AdListByTypePage(this.adType, {super.key});

  final AdType adType;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adType);
  }

  @override
  Widget onWidgetBuild(BuildContext context, AdListByTypeState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: SearchAppBar2(
          backgroundColor: context.appBarColor,
          listener: () => context.router.pop(),
          listenerSearch: () => context.router.push(SearchRoute()),
          listenerNotification: () =>
              context.router.push(NotificationListRoute()),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16, left: 16, top: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: switch (adType) {
                        AdType.PRODUCT => Strings.favoriteProductTitle
                            .w(700)
                            .s(16)
                            .c(context.textPrimary),
                        AdType.SERVICE => Strings.favoriteServiceTitle
                            .w(700)
                            .s(16)
                            .c(context.textPrimary),
                      },
                    ),
                  ),
                  SeeAllWidget(
                    onClicked: () {
                      context.router.push(AdListRoute(
                        adType: state.adType,
                        adListType: AdListType.cheaperAdsByAdType,
                        keyWord: '',
                        title: Strings.adListLowPricesLabel,
                      ));
                    },
                    title: Strings.adListLowPricesLabel,
                  ),
                  LoaderStateWidget(
                    isFullScreen: false,
                    loadingState: state.cheapAdsState,
                    loadingBody: HorizontalAdListShimmer(),
                    successBody: HorizontalAdListWidget(
                      ads: state.cheapAds,
                      onItemClicked: (Ad result) {
                        context.router.push(AdDetailRoute(adId: result.id));
                      },
                      onFavoriteClicked: (Ad result) {
                        cubit(context).cheapAdsAddFavorite(result);
                      },
                      onCartClicked: (Ad ad) {},
                      onBuyClicked: (Ad ad) {
                        context.router.push(OrderCreationRoute(adId: ad.id));
                      },
                    ),
                  ),
                  SizedBox(height: 6),
                  CustomDivider(height: 3),
                  SeeAllWidget(
                    onClicked: () {
                      context.router.push(AdListRoute(
                        adType: state.adType,
                        adListType: AdListType.popularAdsByAdType,
                        keyWord: '',
                        title: Strings.adListPopularLabel,
                      ));
                    },
                    title: Strings.adListPopularLabel,
                  ),
                  SizedBox(height: 6),
                  LoaderStateWidget(
                    isFullScreen: false,
                    loadingState: state.popularAdsState,
                    loadingBody: HorizontalAdListShimmer(),
                    successBody: HorizontalAdListWidget(
                      ads: state.popularAds,
                      onItemClicked: (Ad ad) {
                        context.router.push(AdDetailRoute(adId: ad.id));
                      },
                      onFavoriteClicked: (Ad ad) {
                        cubit(context).popularAdsAddFavorite(ad);
                      },
                      onCartClicked: (Ad ad) {},
                      onBuyClicked: (Ad ad) {
                        context.router.push(OrderCreationRoute(adId: ad.id));
                      },
                    ),
                  ),
                  SizedBox(height: 6),
                  CustomDivider(height: 3),
                  SizedBox(height: 24)
                ],
              ),
            ),
            state.controller == null
                ? SizedBox()
                : PagedSliverGrid<int, Ad>(
                    pagingController: state.controller!,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: width / height,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      crossAxisCount: 2,
                      mainAxisExtent: 292,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<Ad>(
                      firstPageErrorIndicatorBuilder: (_) {
                        return DefaultErrorWidget(
                          isFullScreen: true,
                          onRetryClicked: () =>
                              cubit(context).states.controller?.refresh(),
                        );
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
                          child: Text(Strings.commonEmptyMessage),
                        );
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
                        return DefaultErrorWidget(
                          isFullScreen: false,
                          onRetryClicked: () =>
                              cubit(context).states.controller?.refresh(),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 100),
                      itemBuilder: (context, item, index) {
                        if (index % 2 == 1) {
                          return Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: VerticalAdWidget(
                              ad: item,
                              onItemClicked: (ad) {
                                context.router.push(AdDetailRoute(adId: ad.id));
                              },
                              onFavoriteClicked: (ad) {
                                cubit(context).addFavorite(ad);
                              },
                              onCartClicked: (Ad ad) {},
                              onBuyClicked: (Ad ad) {
                                context.router
                                    .push(OrderCreationRoute(adId: ad.id));
                              },
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: VerticalAdWidget(
                              ad: item,
                              onItemClicked: (ad) {
                                context.router.push(AdDetailRoute(adId: ad.id));
                              },
                              onFavoriteClicked: (ad) {
                                cubit(context).addFavorite(ad);
                              },
                              onCartClicked: (Ad ad) {},
                              onBuyClicked: (Ad ad) {
                                context.router
                                    .push(OrderCreationRoute(adId: ad.id));
                              },
                            ),
                          );
                        }
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
