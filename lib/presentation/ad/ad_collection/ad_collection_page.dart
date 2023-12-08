import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/ad_group_widget.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_active_search_bar.dart';
import 'package:onlinebozor/common/widgets/dashboard/all_view_widget.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';

import '../../../common/core/base_page.dart';
import '../../../common/widgets/ad/ad_widget.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../domain/models/ad.dart';
import '../../../domain/util.dart';
import 'cubit/ad_collection_cubit.dart';

@RoutePage()
class AdCollectionPage extends BasePage<AdCollectionCubit,
    AdCollectionBuildable, AdCollectionListenable> {
  const AdCollectionPage(this.collectiveType, {super.key});

  final CollectiveType collectiveType;

  @override
  void init(BuildContext context) {
    context.read<AdCollectionCubit>().setCollectionType(collectiveType);
  }

  @override
  void listener(BuildContext context, AdCollectionListenable state) {
    switch (state.effect) {
      case AdsCollectionEffect.success:
        () {};
      case AdsCollectionEffect.navigationToAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget builder(BuildContext context, AdCollectionBuildable state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonActiveSearchBar(
                listener: () => context.router.pop(),
                listenerSearch: () => context.router.push(SearchRoute()),
                listenerNotification: () =>
                    context.router.push(NotificationRoute())),
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
                          child: switch (collectiveType) {
                            CollectiveType.product => Strings
                                .favoriteProductTitle
                                .w(700)
                                .s(16)
                                .c(context.colors.textPrimary),
                            CollectiveType.service => Strings
                                .favoriteServiceTitle
                                .w(700)
                                .s(16)
                                .c(context.colors.textPrimary),
                          },
                        )),
                    AppAllViewWidget(
                        listener: () {
                          context.router.push(AdListRoute(
                              adListType: AdListType.list,
                              keyWord: '',
                              title: Strings.recentlyViewedTitle));
                        },
                        title: Strings.recentlyViewedTitle),
                    LoaderStateWidget(
                        isFullScreen: false,
                        loadingState: state.hotDiscountAdsState,
                        child: AdGroupWidget(
                          ads: state.hotDiscountAds,
                          invoke: (Ad result) {
                            context.router.push(AdDetailRoute(adId: result.id));
                          },
                          invokeFavorite: (Ad result) => context
                              .read<AdCollectionCubit>()
                              .discountAdsAddFavorite(result),
                      )),
                      SizedBox(height: 6),
                      AppDivider(height: 3),
                      AppAllViewWidget(
                          listener: () {
                          context.router.push(AdListRoute(
                              adListType: AdListType.list,
                              keyWord: '',
                              title: Strings.adCollectivePopular));
                        },
                          title: Strings.adCollectivePopular),
                      SizedBox(height: 6),
                      LoaderStateWidget(
                          isFullScreen: false,
                          loadingState: state.popularAdsState,
                          child: AdGroupWidget(
                            ads: state.popularAds,
                            invoke: (Ad result) {
                            context.router.push(AdDetailRoute(adId: result.id));
                          },
                            invokeFavorite: (Ad result) => context
                              .read<AdCollectionCubit>()
                              .popularAdsAddFavorite(result),
                      )),
                      SizedBox(height: 6),
                      AppDivider(height: 3),
                      SizedBox(height: 24)
                    ],
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
                                  invokeFavorite: (value) => context
                                      .read<AdCollectionCubit>()
                                      .addFavorite(value),
                                  invoke: (value) => context.router
                                      .push(AdDetailRoute(adId: value.id)),
                                ),
                              );
                      } else {
                              return Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: AppAdWidget(
                                  ad: item,
                                  invokeFavorite: (value) => context
                                      .read<AdCollectionCubit>()
                                      .addFavorite(value),
                                  invoke: (value) => context.router
                                      .push(AdDetailRoute(adId: value.id)),
                                ),
                              );
                            }
                          },
                        ))
              ],
            )));
  }
}