import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
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
import 'package:onlinebozor/presentation/widgets/dashboard/see_all_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'ad_list_by_type_cubit.dart';

@RoutePage()
class AdListByTypePage
    extends BasePage<AdListByTypeCubit, AdListByTypeState, AdListByTypeEvent> {
  const AdListByTypePage(this.adType, {super.key});

  final AdType adType;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adType);
  }

  @override
  Widget onWidgetBuild(BuildContext context, AdListByTypeState state) {
    return Center(
      child: Scaffold(
        backgroundColor: context.backgroundGreyColor,
        appBar: _buildAppBar(context),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            _buildHorizontalAds(context, state),
            _buildVerticalAdsList(context, state)
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.appBarColor,
      elevation: 0.5,
      toolbarHeight: 64,
      leading: IconButton(
        onPressed: () => context.router.pop(),
        icon: Assets.images.icArrowLeft.svg(),
      ),
      actions: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: 64,
              top: 12,
              bottom: 12,
              right: 16,
            ),
            child: InkWell(
              onTap: () => context.router.push(SearchRoute()),
              borderRadius: BorderRadius.circular(6),
              child: Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Assets.images.iconSearch.svg(),
                    SizedBox(width: 6),
                    Expanded(
                      child: Strings.searchHintCategoryAndProducts
                          .w(400)
                          .s(14)
                          .c(context.textSecondary)
                          .copyWith(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  SliverToBoxAdapter _buildHorizontalAds(
    BuildContext context,
    AdListByTypeState state,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SeeAllWidget(
            onClicked: () {
              context.router.push(AdListRoute(
                adType: state.adType,
                adListType: AdListType.cheaperAdsByAdType,
                keyWord: '',
                title: state.adType == AdType.service
                    ? Strings.adListLowPriceServices
                    : Strings.adListLowPriceProducts,
              ));
            },
            title: state.adType == AdType.service
                ? Strings.adListLowPriceServices
                : Strings.adListLowPriceProducts,
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
          SeeAllWidget(
            onClicked: () {
              context.router.push(AdListRoute(
                adType: state.adType,
                adListType: AdListType.popularAdsByAdType,
                keyWord: '',
                title: state.adType == AdType.service
                    ? Strings.adListPopularServices
                    : Strings.adListPopularProducts,
              ));
            },
            title: state.adType == AdType.service
                ? Strings.adListPopularServices
                : Strings.adListPopularProducts,
          ),
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
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (state.adType == AdType.service
                        ? Strings.adListInterestingServices
                        : Strings.adListInterestingProducts)
                    .w(600)
                    .s(16)
                    .c(context.textPrimary),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildVerticalAdsList(BuildContext context, AdListByTypeState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return state.controller == null
        ? SizedBox()
        : PagedSliverGrid<int, Ad>(
            pagingController: state.controller!,
            showNewPageProgressIndicatorAsGridChild: false,
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
                        context.router.push(OrderCreationRoute(adId: ad.id));
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
                        context.router.push(OrderCreationRoute(adId: ad.id));
                      },
                    ),
                  );
                }
              },
            ),
          );
  }
}
