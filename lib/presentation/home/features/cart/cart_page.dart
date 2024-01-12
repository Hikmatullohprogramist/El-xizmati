import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/favorite/favorite_empty_widget.dart';

import '../../../../common/widgets/cart/cart_widget.dart';
import '../../../../domain/models/ad.dart';
import 'cubit/cart_cubit.dart';

@RoutePage()
class CartPage extends BasePage<CartCubit, CartBuildable, CartListenable> {
  const CartPage({super.key});

  @override
  Widget builder(BuildContext context, CartBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Strings.bottomNavigationCart
            .w(500)
            .s(14)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        // actions: [
        //   if (true)
        //     CommonButton(
        //         type: ButtonType.text,
        //         onPressed: () {},
        //         child: "Выбрать все".w(500).s(12).c(Color(0xFF5C6AC3)))
        // ],
      ),
      backgroundColor: Colors.white,
      body: PagedGridView<int, Ad>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.adsPagingController!,
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
                      CommonButton(
                          onPressed: () {},
                          type: ButtonType.elevated,
                          child: Strings.loadingStateRetry.w(400).s(15))
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
              return FavoriteEmptyWidget(invoke: () {
                context.router.push(DashboardRoute());
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
                invokeAdd: (Ad ad) {},
                invokeMinus: (Ad ad) {},
                invokeDelete: (Ad ad) =>
                    context.read<CartCubit>().removeCart(ad),
                invokeFavoriteDelete: (Ad ad) {
                  context.read<CartCubit>().addFavorite(ad);
                },
                ad: item,
                invoke: (Ad ad) {
                  context.router.push(OrderCreateRoute(adId: ad.id));
                },
              );

              //   AppAdWidget(
              //   result: item,
              //   onClickFavorite: (value) {},
              //   onClick: (value) {
              //     context.router.push(AdDetailRoute(adId: value.id));
              //   },
              // )
            }),
      ),
    );
  }
}
