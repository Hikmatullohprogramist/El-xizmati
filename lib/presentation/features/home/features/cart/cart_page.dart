import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/cart/cart_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/cart/cart_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/favorite_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class CartPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CartPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: EmptyAppBar(
        titleText: Strings.bottomNavigationCart,
        backgroundColor: context.appBarColor,
      ),
      backgroundColor: context.backgroundColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.loadState,
        loadingBody: _buildLoadingBody(),
        successBody: _buildSuccessBody(context, state),
        emptyBody: FavoriteEmptyWidget(
          onActionClicked: () => context.router.push(DashboardRoute()),
        ),
        onRetryClicked: () => cubit(context).getItems(),
      ),
    );
  }

  Widget _buildLoadingBody() {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return CartShimmer();
        },
      ),
    );
  }

  Widget _buildSuccessBody(BuildContext context, PageState state) {
    return RefreshIndicator(
      displacement: 160,
      strokeWidth: 3,
      color: StaticColors.colorPrimary,
      onRefresh: () async {
        cubit(context).getItems();
      },
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: state.items.length,
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        itemBuilder: (context, index) {
          return CartWidget(
            ad: state.items[index],
            onDeleteClicked: (Ad ad) {
              vibrateAsHapticFeedback();
              cubit(context).removeFromCart(ad);
            },
            onFavoriteClicked: (Ad ad) {
              vibrateAsHapticFeedback();
              cubit(context).changeFavorite(ad);
            },
            onProductClicked: (Ad ad) {
              context.router.push(AdDetailRoute(adId: ad.id));
            },
            onOrderClicked: (Ad ad) {
              context.router.push(CreateOrderRoute(adId: ad.id));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16, height: 8);
        },
      ),
    );
  }
}
