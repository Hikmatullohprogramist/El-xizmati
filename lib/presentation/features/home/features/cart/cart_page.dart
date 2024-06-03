import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/cart/cart_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/cart/cart_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/favorite_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/loader_state_widget.dart';

import 'cart_cubit.dart';

@RoutePage()
class CartPage extends BasePage<CartCubit, CartState, CartEvent> {
  const CartPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, CartState state) {
    return Scaffold(
      appBar: EmptyAppBar(
        titleText: Strings.bottomNavigationCart,
        backgroundColor: context.appBarColor,
        textColor: context.textPrimary,
      ),
      backgroundColor: context.backgroundColor,
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.cartAdsState,
        loadingBody: _buildLoadingBody(),
        successBody: _buildSuccessBody(context, state),
        emptyBody: FavoriteEmptyWidget(
          onActionClicked: () => context.router.push(DashboardRoute()),
        ),
        onRetryClicked: () => cubit(context).getCartAds(),
      ),
    );
  }

  Widget _buildLoadingBody() {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return CartShimmer();
        },
      ),
    );
  }

  Widget _buildSuccessBody(BuildContext context, CartState state) {
    return RefreshIndicator(
      displacement: 160,
      strokeWidth: 3,
      color: StaticColors.colorPrimary,
      onRefresh: () async {
        cubit(context).getCartAds();
      },
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: state.cardAds.length,
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        itemBuilder: (context, index) {
          return CartWidget(
            ad: state.cardAds[index],
            onDeleteClicked: (Ad ad) {
              showYesNoBottomSheet(
                context,
                title: Strings.messageTitleWarning,
                message: Strings.cartAdRemoveMessage,
                noTitle: Strings.commonNo,
                onNoClicked: () {},
                yesTitle: Strings.commonYes,
                onYesClicked: () {
                  cubit(context).removeFromCart(ad);
                },
              );
            },
            onFavoriteClicked: (Ad ad) {
              HapticFeedback.lightImpact();
              cubit(context).changeFavorite(ad);
            },
            onProductClicked: (Ad ad) {
              context.router.push(AdDetailRoute(adId: ad.id));
            },
            onOrderClicked: (Ad ad) {
              context.router.push(OrderCreationRoute(adId: ad.id));
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
