
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/top_rated_ad_list_widget.dart';

import '../../../../common/colors/static_colors.dart';
import '../../../../common/enum/enums.dart';
import '../../../../common/gen/assets/assets.gen.dart';
import '../../../../common/gen/localization/strings.dart';
import '../../../../common/widgets/ad/horizontal_ad_list_widget.dart';
import '../../../../common/widgets/app_bar/search_app_bar.dart';
import '../../../../common/widgets/category/popular_category_list_widget.dart';
import '../../../../common/widgets/dashboard/banner_widget.dart';
import '../../../../common/widgets/dashboard/product_or_service.dart';
import '../../../../common/widgets/dashboard/see_all_widget.dart';
import '../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_list_type.dart';
import '../../../../domain/models/ad/ad_type.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class DashboardPage extends BasePage<PageCubit, PageState, PageEvent> {
  const DashboardPage({super.key});
  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getRecentlyViewedAds();
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: SearchAppBar(
        onSearchClicked: () => context.router.push(SearchRoute()),
        onMicrophoneClicked: () {},
        onFavoriteClicked: () => context.router.push(FavoriteListRoute()),
        onNotificationClicked: () =>
            context.router.push(NotificationListRoute()),
      ),
      backgroundColor: StaticColors.backgroundColor,
      body: RefreshIndicator(
        displacement: 160,
        strokeWidth: 3,
        color: Color(0xFF586BC2),
        onRefresh: () async{
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

  Widget _getBannersWidget(BuildContext context, PageState state) {
    return LoaderStateWidget(
      onRetryClicked: () {
        cubit(context).getBanners();
      },
      isFullScreen: false,
      loadingState: state.bannersState,
      successBody: BannerWidget(
        list: state.banners,
        loadingState: state.bannersState,
      ),
    );
  }

  Widget _getPopularCategoriesWidget(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SeeAllWidget(
            onClicked: () => context.router.push(
              PopularCategoriesRoute(title: Strings.categoriesTitle),
            ),
            title: Strings.categoriesTitle,
          ),
          LoaderStateWidget(
            onRetryClicked: () {
              cubit(context).getPopularCategories();
            },
            isFullScreen: false,
            loadingState: state.popularCategoriesState,
            successBody: PopularCategoryListWidget(
              categories: state.popularCategories,
              invoke: (popularCategories) {
                context.router.push(
                  AdListRoute(
                    adListType: AdListType.homeList,
                    keyWord: popularCategories.key_word,
                    title: popularCategories.name,
                    sellerTin: null,
                  ),
                );
              },
              loadingState: state.popularCategoriesState,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAdTypeChooserWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
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
      ),
    );
  }

  Widget _getDashboardProductAdsWidget(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      child: Column(
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
            successBody: HorizontalAdListWidget(
              ads: state.popularProductAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                cubit(context).popularProductAdsAddFavorite(ad);
              },
              loadingState: state.popularProductAdsState,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDashboardServiceAdsWidget(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      child: Column(
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
            successBody: HorizontalAdListWidget(
              ads: state.popularServiceAds,
              onItemClicked: (Ad ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (Ad ad) {
                cubit(context).popularServiceAdsAddFavorite(ad);
              },
              loadingState: state.popularServiceAdsState,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTopRatedAdsWidget(BuildContext context, PageState state) {
    return LoaderStateWidget(
      isFullScreen: false,
      onRetryClicked: () {
        cubit(context).getTopRatedAds();
      },
      loadingState: state.popularServiceAdsState,
      successBody: TopRatedAdListWidget(
        ads: state.topRatedAds,
        onItemClicked: (Ad ad) {
          context.router.push(AdDetailRoute(adId: ad.id));
        },
        onOnClickBuyClicked: (Ad ad) {
          context.router.push(CreateOrderRoute(adId: ad.id));
        },
        onFavoriteClicked: (Ad ad) {
          cubit(context).topRatedAdsAddFavorite(ad);
        },
        loadingState: state.popularServiceAdsState,
      ),
    );
  }

  Widget _getRecentlyViewedAdsWidget(
    BuildContext context,
    PageState state,
  ) {
    return Visibility(
      visible:
     state.recentlyViewedAdsState != LoadingState.loading &&
         (state.recentlyViewedAdsState ==
             LoadingState.success && state.recentlyViewedAds.isNotEmpty),
      child: Container(
        color: Colors.white,
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
              successBody: HorizontalAdListWidget(
                ads: state.recentlyViewedAds,
                onItemClicked: (Ad ad) {
                  context.router.push(AdDetailRoute(adId: ad.id));
                },
                onFavoriteClicked: (Ad ad) {
                  context.read<PageCubit>().recentlyViewAdAddToFavorite(ad);
                },
                loadingState: state.recentlyViewedAdsState,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
