import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/ad/vertical/vertical_ad_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/ad/vertical/vertical_ad_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/favorite_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';

import 'favorite_services_cubit.dart';

@RoutePage()
class FavoriteServicesPage extends BasePage<FavoriteServicesCubit, FavoriteServicesState, FavoriteServicesEvent> {
  const FavoriteServicesPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, FavoriteServicesState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: context.backgroundGreyColor,
      body: RefreshIndicator(
        displacement: 160,
        strokeWidth: 3,
        color: StaticColors.colorPrimary,
        onRefresh: () async {
          cubit(context).states.controller!.refresh();
        },
        child: PagedGridView<int, Ad>(
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio: 0.60,
                  crossAxisSpacing: 15.0, // Spacing between columns
                  mainAxisSpacing: 1.0,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return VerticalAdShimmer();
                },
              );
            },
            noItemsFoundIndicatorBuilder: (_) {
              return FavoriteEmptyWidget(onActionClicked: () {
                context.router.replace(DashboardRoute());
              });
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
              return DefaultErrorWidget(
                isFullScreen: false,
                onRetryClicked: () =>
                    cubit(context).states.controller?.refresh(),
              );
            },
            transitionDuration: Duration(milliseconds: 100),
            itemBuilder: (context, item, index) => VerticalAdWidget(
              ad: item,
              onItemClicked: (ad) {
                context.router.push(AdDetailRoute(adId: ad.id));
              },
              onFavoriteClicked: (ad) {
                cubit(context).removeFavorite(ad);
              },
              onCartClicked: (Ad ad) {},
              onBuyClicked: (Ad ad) {
                context.router.push(OrderCreationRoute(adId: ad.id));
              },
            ),
          ),
        ),
      ),
    );
  }
}
