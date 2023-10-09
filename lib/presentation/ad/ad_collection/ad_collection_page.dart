import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ad/ad_group_widget.dart';
import 'package:onlinebozor/common/widgets/all_view_widget.dart';
import 'package:onlinebozor/common/widgets/app_bar/common_active_search_bar.dart';
import 'package:onlinebozor/common/widgets/app_diverder.dart';

import '../../../common/constants.dart';
import '../../../common/core/base_page.dart';
import '../../../common/widgets/ad/ad_widget.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/loading/loader_state_widget.dart';
import '../../../domain/model/ad/ad_response.dart';
import 'cubit/ad_collection_cubit.dart';

@RoutePage()
class AdCollectionPage extends BasePage<AdCollectionCubit,
    AdCollectionBuildable, AdCollectionListenable> {
  const AdCollectionPage(this.collectiveType, {super.key});

  final CollectiveType collectiveType;

  @override
  Widget builder(BuildContext context, AdCollectionBuildable state) {
    return Center(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonActiveSearchBar(
              onBack: () => context.router.pop(),
              onPressedSearch: () => context.router.push(SearchRoute()),
              onPressedNotification: () =>
                  context.router.push(NotificationRoute())),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, top: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: switch (collectiveType) {
                      CollectiveType.commodity =>
                        'Товары'.w(700).s(16).c(context.colors.textPrimary),
                      CollectiveType.service =>
                        'Услуги'.w(700).s(16).c(context.colors.textPrimary),
                    },
                  )),
              AppAllViewWidget(
                  onPressed: () {
                    context.router.push(
                        AdListRoute(adListType: AdListType.list, keyWord: ''));
                  },
                  title: "Горячие скидки"),
              LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.hotDiscountAdsState,
                  child: AdGroupWidget(
                    ads: state.hotDiscountAds,
                    onClick: (AdResponse result) {
                      context.router.push(AdDetailRoute());
                    },
                    onClickFavorite: (AdResponse result) {},
                  )),
              SizedBox(height: 6),
              AppDivider(height: 3),
              AppAllViewWidget(
                  onPressed: () {
                    context.router.push(
                        AdListRoute(adListType: AdListType.list, keyWord: ''));
                  },
                  title: "Популярные товары"),
              SizedBox(height: 6),
              LoaderStateWidget(
                  isFullScreen: false,
                  loadingState: state.popularAdsState,
                  child: AdGroupWidget(
                    ads: state.popularAds,
                    onClick: (AdResponse result) {
                      context.router.push(AdDetailRoute());
                    },
                    onClickFavorite: (AdResponse result) {},
                  )),
              SizedBox(height: 6),
              AppDivider(height: 3),
              SizedBox(height: 24),
              state.adsPagingController == null
                  ? SizedBox()
                  : PagedGridView<int, AdResponse>(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      pagingController: state.adsPagingController!,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 156 / 302,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 24,
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
                    )
            ]),
          )),
    );
  }
}
