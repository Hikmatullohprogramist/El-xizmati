import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/ads_widget.dart';
import 'package:onlinebozor/common/widgets/all_view_widget.dart';
import 'package:onlinebozor/common/widgets/app_banner_widget.dart';
import 'package:onlinebozor/presentation/ads/ads_collection%20/cubit/ads_collection_cubit.dart';
import 'package:onlinebozor/presentation/ads/ads_list/cubit/ads_list_cubit.dart';

import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/ads_horizontal_widget.dart';
import '../../../common/widgets/app_bar/common_search_bar.dart';
import '../../../common/widgets/commodity_and_service.dart';
import '../../../common/widgets/popular_category.dart';
import '../../../domain/model/ads/ads_response.dart';
import 'cubit/dashboard_cubit.dart';

@RoutePage()
class DashboardPage
    extends BasePage<DashboardCubit, DashboardBuildable, DashboardListenable> {
  DashboardPage({super.key});

  @override
  void init(BuildContext context) {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<DashboardCubit>();
    });
  }

  final PagingController<int, AdsResponse> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  Widget builder(BuildContext context, DashboardBuildable state) {
    return Scaffold(
      appBar: CommonSearchBar(
        onPressedMic: () {},
        onPressedNotification: () {
          context.router.push(NotificationRoute());
        },
        onPressedSearch: () {
          context.router.push(SearchRoute());
        },
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AppCommodityAndService(
                  onPressed: () {
                    context.router.push(AdsCollectionRoute(
                        CollectiveType: CollectiveType.commodity));
                  },
                  color: Color(0xFFB9A0FF),
                  title: Strings.commodityTitle,
                  endColorGradient: Color(0xFFAFA2DA),
                  image: Assets.images.pngImages.commondity.image(),
                  startColorGradient: Color(0xFF9570FF),
                ),
              ),
              Flexible(
                flex: 1,
                child: AppCommodityAndService(
                  onPressed: () {
                    context.router.push(AdsCollectionRoute(
                        CollectiveType: CollectiveType.service));
                  },
                  color: Color(0xFFFFBB79),
                  title: Strings.serviceTitle,
                  endColorGradient: Color(0xFFF0C49A),
                  image: Assets.images.pngImages.service.image(),
                  startColorGradient: Color(0xFFF7993D),
                ),
              )
            ],
          ),
          AppAllViewWidget(
              onPressed: () {
                // context.router
                //     .push(AdsListRoute(adsListType: AdsListType.hotDiscount));
              },
              title: Strings.popularCategories),
          Divider(height: 1.50, color: Color(0xFFE5E9F3)),
          SizedBox(
            height: 156,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 15,
              padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
              itemBuilder: (context, index) {
                return AppPopularCategory(
                  title: 'Kompyuter',
                  image: Assets.images.pc.image(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 16);
              },
            ),
          ),
          Divider(
            height: 6,
            color: Color(0xFFE5E9F3),
          ),
          AppAllViewWidget(
              onPressed: () {
                context.router
                    .push(AdsListRoute(adsListType: AdsListType.hotDiscount));
              },
              title: Strings.hotDiscountsTitle),
          SizedBox(
            height: 342,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 15,
              padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
              itemBuilder: (context, index) {
                return AppAdsHorizontalWidget(
                  onClickFavorite: (value) {
                    Logger log = Logger();
                    log.w(value);
                  },
                  onClick: (value) {
                    Logger log = Logger();
                    log.w(value);
                    context.router.push(AdsDetailRoute());
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 16);
              },
            ),
          ),
          AppBannerWidget(
              list: List.generate(
                  3, (index) => 'http://via.placeholder.com/200x150')),
          SizedBox(height: 24),
          PagedGridView<int, AdsResponse>(
            shrinkWrap: true,
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: _pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 156 / 265,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2,
            ),
            builderDelegate: PagedChildBuilderDelegate<AdsResponse>(
            itemBuilder: (context, item, index) => AppAdsWidget(
                  onClickFavorite: (value) {
                    Logger log = Logger();
                    log.w(value);
                  },
                  onClick: (value) {
                    Logger log = Logger();
                    log.w(value);
                    context.router.push(AdsDetailRoute());
                  },
                )),
          ),
          // GridView.builder(
          //   padding: EdgeInsets.symmetric(horizontal: 16),
          //   shrinkWrap: true,
          //   itemCount: 60,
          //   physics: BouncingScrollPhysics(),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 16,
          //       mainAxisSpacing: 16,
          //       childAspectRatio: 156 / 265),
          //   itemBuilder: (BuildContext context, int index) {
          //     return AppAdsWidget(
          //       onClickFavorite: (value) {
          //         Logger log = Logger();
          //         log.w(value);
          //       },
          //       onClick: (value) {
          //         Logger log = Logger();
          //         log.w(value);
          //         context.router.push(AdsDetailRoute());
          //       },
          //     );
          //   },
          // ),
          // AppBannerWidget(),
        ]),
      )),
    );
  }
}
