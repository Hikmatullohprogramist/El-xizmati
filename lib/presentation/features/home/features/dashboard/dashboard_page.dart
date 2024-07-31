import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/presentation/features/common/region_selection/region_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/set_region/set_region_cubit.dart';
import 'package:onlinebozor/presentation/features/common/set_region/set_region_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/ad/horizontal/horizontal_ad_list_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/ad/horizontal/horizontal_ad_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/top_rated/top_rated_ad_list_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/ad/top_rated/top_rated_ad_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
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
      appBar: _buildAppBar(context, state),
      backgroundColor: context.backgroundWhiteColor,
      body: RefreshIndicator(
        displacement: 80,
        strokeWidth: 3,
        color: StaticColors.colorPrimary,
        onRefresh: () async {
          cubit(context).reload();
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ..._getBannersWidget(context, state),
                  ..._getPopularCategoriesWidget(context, state),
                  _getAdTypeChooserWidget(context),
                  ..._getDashboardProductAdsWidget(context, state),
                  ..._getDashboardServiceAdsWidget(context, state),
                  ..._getTopRatedAdsWidget(context, state),
                  ..._getRecentlyViewedAdsWidget(context, state),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(horizontal: 16)),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, DashboardState state) {
    return AppBar(
      elevation: 0.5,
      toolbarHeight: 120,
      leading: Assets.images.icArrowLeft.svg(color: Colors.transparent),
      backgroundColor: context.appBarColor,
      actions: [
        Flexible(
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 6),
                    child: InkWell(
                      onTap: () async {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => SetRegionPage(),
                        );
                        HapticFeedback.lightImpact();
                      },
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(width: 8),
                            Expanded(
                              child: state.actualRegionName
                                  .w(600)
                                  .s(14)
                                  .c(Color(0xFF494B50))
                                  .copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                            SizedBox(width: 4),
                            Assets.images.icArrowDown.svg(),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => context.router.push(FavoriteListRoute()),
                  icon: Assets.images.bottomBar.favorite
                      .svg(color: Color(0xFF5C6AC4)),
                ),
                IconButton(
                  onPressed: () => context.router.push(NotificationListRoute()),
                  icon: Assets.images.icNotification
                      .svg(color: Color(0xFF5C6AC4)),
                )
              ]),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 16, top: 0, bottom: 12, right: 6),
                  child: InkWell(
                    onTap: () => context.router.push(SearchRoute()),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.inputBackgroundColor,
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
          ),
        ),
      ],
    );
  }

  List<Widget> _getBannersWidget(BuildContext context, DashboardState state) {
    return [
      LoaderStateWidget(
        onRetryClicked: () {
          cubit(context).getBanners();
        },
        isFullScreen: false,
        loadingState: state.bannersState,
        loadingBody: BannerListShimmer(),
        successBody: BannerListWidget(banners: state.banners),
      )
    ];
  }

  List<Widget> _getPopularCategoriesWidget(
    BuildContext context,
    DashboardState state,
  ) {
    return [
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
    ];
  }

  Widget _getAdTypeChooserWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: ProductOrService(
            invoke: () {
              context.router.push(AdListByTypeRoute(adType: AdType.product));
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
              context.router.push(AdListByTypeRoute(adType: AdType.service));
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

  List<Widget> _getDashboardProductAdsWidget(
    BuildContext context,
    DashboardState state,
  ) {
    return [
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
    ];
  }

  List<Widget> _getDashboardServiceAdsWidget(
    BuildContext context,
    DashboardState state,
  ) {
    return [
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
    ];
  }

  List<Widget> _getTopRatedAdsWidget(
    BuildContext context,
    DashboardState state,
  ) {
    return [
      LoaderStateWidget(
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
      )
    ];
  }

  List<Widget> _getRecentlyViewedAdsWidget(
    BuildContext context,
    DashboardState state,
  ) {
    return [
      Visibility(
        visible: state.isRecentlyViewedAdsVisible,
        child: SeeAllWidget(
          onClicked: () {
            context.router.push(
              AdListRoute(
                adListType: AdListType.recentlyViewedAds,
                keyWord: '',
                title: Strings.recentlyViewedTitle,
                sellerTin: null,
              ),
            );
          },
          title: Strings.recentlyViewedTitle,
        ),
      ),
      Visibility(
        visible: state.isRecentlyViewedAdsVisible,
        child: LoaderStateWidget(
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
      ),
    ];
  }
}
