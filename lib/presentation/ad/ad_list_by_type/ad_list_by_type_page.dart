import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/search_app_bar_2.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/dashboard/see_all_widget.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';

import '../../../common/core/base_page.dart';
import '../../../common/widgets/ad/horizontal/horizontal_ad_list_shimmer.dart';
import '../../../common/widgets/ad/horizontal/horizontal_ad_list_widget.dart';
import '../../../common/widgets/ad/vertical/vertical_ad_widget.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../domain/models/ad/ad.dart';
import '../../../domain/models/ad/ad_list_type.dart';
import '../../../domain/models/ad/ad_type.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class AdListByTypePage extends BasePage<PageCubit, PageState, PageEvent> {
  const AdListByTypePage(this.adType, {super.key});

  final AdType adType;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adType);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: SearchAppBar2(
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
                            .c(context.colors.textPrimary),
                        AdType.SERVICE => Strings.favoriteServiceTitle
                            .w(700)
                            .s(16)
                            .c(context.colors.textPrimary),
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
                      onItemClicked: (Ad result) {
                        context.router.push(AdDetailRoute(adId: result.id));
                      },
                      onFavoriteClicked: (Ad result) => context
                          .read<PageCubit>()
                          .popularAdsAddFavorite(result),
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
                                Strings.commonEmptyMessage
                                    .w(400)
                                    .s(14)
                                    .c(context.colors.textPrimary),
                                SizedBox(height: 12),
                                CustomElevatedButton(
                                  text: Strings.commonRetry,
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
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
                            child: VerticalAdWidget(
                              ad: item,
                              onFavoriteClicked: (value) =>
                                  cubit(context).addFavorite(value),
                              onClicked: (value) => context.router
                                  .push(AdDetailRoute(adId: value.id)),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: VerticalAdWidget(
                              ad: item,
                              onFavoriteClicked: (value) =>
                                  cubit(context).addFavorite(value),
                              onClicked: (value) => context.router
                                  .push(AdDetailRoute(adId: value.id)),
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
