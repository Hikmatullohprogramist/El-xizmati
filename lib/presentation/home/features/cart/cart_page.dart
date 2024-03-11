import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/favorite/favorite_empty_widget.dart';

import '../../../../common/colors/static_colors.dart';
import '../../../../common/widgets/cart/cart_widget.dart';
import '../../../../common/widgets/cart/cart_widget_shimmer.dart';
import '../../../../domain/models/ad/ad.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CartPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CartPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: EmptyAppBar(titleText: Strings.bottomNavigationCart),
      backgroundColor: StaticColors.backgroundColor,
      body: PagedGridView<int, Ad>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 16),
        pagingController: state.controller!,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 360 / 142,
          // mainAxisSpacing: 24,
          crossAxisCount: 1,
        ),
        builderDelegate: PagedChildBuilderDelegate<Ad>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Strings.loadingStateError
                        .w(400)
                        .s(14)
                        .c(context.colors.textPrimary),
                    SizedBox(height: 12),
                    CustomElevatedButton(
                      text: Strings.loadingStateRetry,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SingleChildScrollView(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return CartWidgetShimmer();
                },
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return FavoriteEmptyWidget(
              onActionClicked: () => context.router.push(DashboardRoute()),
            );
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
          itemBuilder: (context, item, index) {
            return CartWidget(
              ad: item,
              onDeleteClicked: (Ad ad) => cubit(context).removeCart(ad),
              onFavoriteClicked: (Ad ad) => cubit(context).addFavorite(ad),
              onOrderClicked: (Ad ad) {
                context.router.push(OrderCreateRoute(adId: ad.id));
              },
            );
          },
        ),
      ),
    );
  }
}
