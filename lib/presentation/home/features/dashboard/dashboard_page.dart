import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../common/gen/localization/strings.dart';
import '../../../../common/widgets/ad/ad_widget.dart';
import '../../../../common/widgets/ad/horizontal_ad_list_widget.dart';
import '../../../../common/widgets/app_bar/common_search_bar.dart';
import '../../../../common/widgets/category/popular_category_list_widget.dart';
import '../../../../common/widgets/common/common_button.dart';
import '../../../../common/widgets/dashboard/banner_widget.dart';
import '../../../../common/widgets/dashboard/see_all_widget.dart';
import '../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../domain/models/ad.dart';
import '../../../../domain/util.dart';
import 'cubit/dashboard_cubit.dart';

@RoutePage()
class DashboardPage
    extends BasePage<DashboardCubit, DashboardBuildable, DashboardListenable> {
  const DashboardPage({super.key});

  @override
  void listener(BuildContext context, DashboardListenable state) {
    switch (state.effect) {
      case DashboardEffect.success:
        () {};
      case DashboardEffect.navigationToAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget builder(BuildContext context, DashboardBuildable state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CommonSearchBar(
          listenerMic: () {},
          listenerNotification: () => context.router.push(NotificationRoute()),
          listenerSearch: () => context.router.push(SearchRoute()),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  LoaderStateWidget(
                      onErrorToAgainRequest: () {
                        context.read<DashboardCubit>().getBanners();
                      },
                      isFullScreen: false,
                      loadingState: state.bannersState,
                      child: BannerWidget(list: state.banners)),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SeeAllWidget(
                          listener: () => context.router.push(
                            PopularCategoriesRoute(
                                title: Strings.categoriesTitle),
                          ),
                          title: Strings.categoriesTitle,
                        ),
                        LoaderStateWidget(
                            onErrorToAgainRequest: () {
                              context
                                  .read<DashboardCubit>()
                                  .getPopularCategories();
                            },
                            isFullScreen: false,
                            loadingState: state.popularCategoriesState,
                            child: PopularCategoryListWidget(
                              categories: state.popularCategories,
                              invoke: (popularCategories) {
                                context.router.push(
                                  AdListRoute(
                                      adListType: AdListType.homeList,
                                      keyWord: popularCategories.key_word,
                                      title: popularCategories.name,
                                      sellerTin: null),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SeeAllWidget(
                            listener: () {
                              context.router.push(
                                AdListRoute(
                                  adListType: AdListType.homePopularAds,
                                  keyWord: '',
                                  title: Strings.popularProductTitle,
                                  sellerTin: null,
                                ),
                              );
                            },
                            title: Strings.popularProductTitle),
                        LoaderStateWidget(
                            isFullScreen: false,
                            onErrorToAgainRequest: () {
                              context.read<DashboardCubit>().getPopularAds();
                            },
                            loadingState: state.popularAdsState,
                            child: HorizontalAdListWidget(
                              ads: state.popularAds,
                              invoke: (Ad ad) {
                                context.router.push(AdDetailRoute(adId: ad.id));
                              },
                              invokeFavorite: (Ad ad) {
                                context
                                    .read<DashboardCubit>()
                                    .popularAdsAddFavorite(ad);
                              },
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
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
                : PagedSliverGrid<int, Ad>(
                    pagingController: state.adsPagingController!,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: width / height,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                      mainAxisExtent: 315,
                      crossAxisCount: 2,
                    ),
                    builderDelegate: PagedChildBuilderDelegate<Ad>(
                      firstPageErrorIndicatorBuilder: (_) {
                        return SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: Center(
                                child: Column(
                              children: [
                                Strings.loadingStateError
                                    .w(400)
                                    .s(14)
                                    .c(context.colors.textPrimary),
                                SizedBox(height: 12),
                                CommonButton(
                                    onPressed: () {},
                                    type: ButtonType.elevated,
                                    child: Strings.loadingStateRetrybutton
                                        .w(400)
                                        .s(15))
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
                            child: Text(Strings.loadingStateNotitemfound));
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
                                ad: item,
                                invokeFavorite: (value) {
                                  context
                                      .read<DashboardCubit>()
                                      .addFavorite(value);
                                },
                                invoke: (value) => context.router
                                    .push(AdDetailRoute(adId: value.id))),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: AppAdWidget(
                              ad: item,
                              invokeFavorite: (value) {
                                context
                                    .read<DashboardCubit>()
                                    .addFavorite(value);
                              },
                              invoke: (value) => context.router
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
