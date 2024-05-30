import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/presentation/widgets/ad/horizontal/horizontal_ad_list_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/ad/horizontal/horizontal_ad_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/top_rated/top_rated_ad_list_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/ad/top_rated/top_rated_ad_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/category/popular_category_list_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/category/popular_category_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/dashboard/banner_list_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/dashboard/banner_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/dashboard/product_or_service.dart';
import 'package:onlinebozor/presentation/widgets/dashboard/see_all_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'dashboard_cubit.dart';

@RoutePage()
class DashboardPage
    extends BasePage<DashboardCubit, DashboardState, DashboardEvent> {
  const DashboardPage({super.key});

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getRecentlyViewedAds();
  }

  @override
  Widget onWidgetBuild(BuildContext context, DashboardState state) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 64,
        elevation: 0.5,
        backgroundColor: context.backgroundColor,
        actions: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 6),
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
                        child: Strings.adSearchHint
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
          ),
          IconButton(
            onPressed: () {
              context.router.push(FavoriteListRoute());
              vibrateAsHapticFeedback();
            },
            icon:
                Assets.images.bottomBar.favorite.svg(color: Color(0xFF5C6AC4)),
          ),
          IconButton(
            onPressed: () {
              context.router.push(NotificationListRoute());
              vibrateAsHapticFeedback();
            },
            icon: Assets.images.icNotification.svg(color: Color(0xFF5C6AC4)),
          )
        ],
      ),
      backgroundColor: context.backgroundColor,
      body: RefreshIndicator(
        displacement: 160,
        strokeWidth: 3,
        color: StaticColors.colorPrimary,
        onRefresh: () async {
          cubit(context).getInitialData();
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _getBannersWidget(context, state),
                  _getPopularCategoriesWidget(context, state),
                  _getAdTypeChooserWidget(context),
                  _getDashboardProductAdsWidget(context, state),
                  _getDashboardServiceAdsWidget(context, state),
                  _getTopRatedAdsWidget(context, state),
                  _getRecentlyViewedAdsWidget(context, state),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(horizontal: 16)),
          ],
        ),
      ),
    );
  }

  Widget _getBannersWidget(BuildContext context, DashboardState state) {
    return LoaderStateWidget(
      onRetryClicked: () {
        cubit(context).getBanners();
      },
      isFullScreen: false,
      loadingState: state.bannersState,
      loadingBody: BannerListShimmer(),
      successBody: BannerListWidget(list: state.banners),
    );
  }

  Widget _getPopularCategoriesWidget(
      BuildContext context, DashboardState state) {
    return Column(
      children: [
        SeeAllWidget(
          onClicked: () => context.router.push(
            PopularCategoriesRoute(title: Strings.popularCategoriesTitle),
          ),
          title: Strings.popularCategoriesTitle,
        ),
        LoaderStateWidget(
          onRetryClicked: () {
            cubit(context).getPopularCategories();
          },
          isFullScreen: false,
          loadingState: state.popularCategoriesState,
          loadingBody: PopularCategoryListShimmer(),
          successBody: PopularCategoryListWidget(
            categories: state.popularCategories,
            onCategoryClicked: (popularCategories) {
              context.router.push(
                AdListRoute(
                  adListType: AdListType.homeList,
                  keyWord: popularCategories.key_word,
                  title: popularCategories.name,
                  sellerTin: null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getAdTypeChooserWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: ProductOrService(
            invoke: () {
              context.router.push(AdListByTypeRoute(adType: AdType.PRODUCT));
            },
            color: Color(0xFFB9A0FF),
            title: Strings.productsTitle,
            endColorGradient: Color(0xFFAFA2DA),
            image: Assets.images.pngImages.commondity.image(),
            startColorGradient: Color(0xFF9570FF),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: ProductOrService(
            invoke: () {
              context.router.push(AdListByTypeRoute(adType: AdType.SERVICE));
            },
            color: Color(0xFFFFBB79),
            title: Strings.servicesTitle,
            endColorGradient: Color(0xFFF0C49A),
            image: Assets.images.pngImages.service.image(),
            startColorGradient: Color(0xFFF7993D),
          ),
        ),
        SizedBox(width: 16)
      ],
    );
  }

  Widget _getDashboardProductAdsWidget(
      BuildContext context, DashboardState state) {
    return Column(
      children: [
        SeeAllWidget(
          onClicked: () {
            context.router.push(
              AdListRoute(
                adListType: AdListType.homePopularAds,
                keyWord: '',
                title: Strings.popularProducts,
                sellerTin: null,
              ),
            );
          },
          title: Strings.popularProducts,
        ),
        LoaderStateWidget(
          isFullScreen: false,
          onRetryClicked: () {
            cubit(context).getPopularProductAds();
          },
          loadingState: state.popularProductAdsState,
          loadingBody: HorizontalAdListShimmer(),
          successBody: HorizontalAdListWidget(
            ads: state.popularProductAds,
            onItemClicked: (Ad ad) {
              context.router.push(AdDetailRoute(adId: ad.id));
            },
            onFavoriteClicked: (Ad ad) {
              cubit(context).popularProductAdsUpdateFavorite(ad);
            },
            onCartClicked: (Ad ad) {
              cubit(context).popularProductAdsUpdateCart(ad);
            },
            onBuyClicked: (Ad ad) {
              context.router.push(OrderCreationRoute(adId: ad.id));
            },
          ),
        ),
      ],
    );
  }

  Widget _getDashboardServiceAdsWidget(
      BuildContext context, DashboardState state) {
    return Column(
      children: [
        SeeAllWidget(
          onClicked: () {
            context.router.push(
              AdListRoute(
                adListType: AdListType.homePopularAds,
                keyWord: '',
                title: Strings.popularServices,
                sellerTin: null,
              ),
            );
          },
          title: Strings.popularServices,
        ),
        LoaderStateWidget(
          isFullScreen: false,
          onRetryClicked: () {
            cubit(context).getPopularServiceAds();
          },
          loadingState: state.popularServiceAdsState,
          loadingBody: HorizontalAdListShimmer(),
          successBody: HorizontalAdListWidget(
            ads: state.popularServiceAds,
            onItemClicked: (Ad ad) {
              context.router.push(AdDetailRoute(adId: ad.id));
            },
            onFavoriteClicked: (Ad ad) {
              cubit(context).popularServiceAdsUpdateFavorite(ad);
            },
            onCartClicked: (Ad ad) {
              cubit(context).popularServiceAdsUpdateCart(ad);
            },
            onBuyClicked: (Ad ad) {
              context.router.push(OrderCreationRoute(adId: ad.id));
            },
          ),
        ),
      ],
    );
  }

  Widget _getTopRatedAdsWidget(BuildContext context, DashboardState state) {
    return LoaderStateWidget(
      isFullScreen: false,
      onRetryClicked: () {
        cubit(context).getTopRatedAds();
      },
      loadingState: state.popularServiceAdsState,
      loadingBody: TopRatedAdListShimmer(),
      successBody: TopRatedAdListWidget(
        ads: state.topRatedAds,
        onItemClicked: (Ad ad) {
          context.router.push(AdDetailRoute(adId: ad.id));
        },
        onOnClickBuyClicked: (Ad ad) {
          context.router.push(OrderCreationRoute(adId: ad.id));
        },
        onFavoriteClicked: (Ad ad) {
          cubit(context).topRatedAdsUpdateFavorite(ad);
        },
      ),
    );
  }

  Widget _getRecentlyViewedAdsWidget(
    BuildContext context,
    DashboardState state,
  ) {
    return Visibility(
      visible: state.recentlyViewedAdsState == LoadingState.loading ||
          (state.recentlyViewedAdsState == LoadingState.success &&
              state.recentlyViewedAds.isNotEmpty),
      child: Column(
        children: [
          SeeAllWidget(
            onClicked: () {
              context.router.push(
                AdListRoute(
                  adListType: AdListType.homeList,
                  keyWord: '',
                  title: Strings.recentlyViewedTitle,
                  sellerTin: null,
                ),
              );
            },
            title: Strings.recentlyViewedTitle,
          ),
          LoaderStateWidget(
            isFullScreen: false,
            onRetryClicked: () {
              cubit(context).getRecentlyViewedAds();
            },
            loadingState: state.recentlyViewedAdsState,
            loadingBody: HorizontalAdListShimmer(),
            successBody: HorizontalAdListWidget(
              ads: state.recentlyViewedAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                cubit(context).recentlyViewAdUpdateFavorite(ad);
              },
              onCartClicked: (Ad ad) {
                cubit(context).recentlyViewAdUpdateCart(ad);
              },
              onBuyClicked: (Ad ad) {
                context.router.push(OrderCreationRoute(adId: ad.id));
              },
            ),
          ),
        ],
      ),
    );
  }
}
