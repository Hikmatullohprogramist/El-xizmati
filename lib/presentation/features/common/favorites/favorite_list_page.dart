import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'favorite_list_cubit.dart';

@RoutePage()
class FavoriteListPage
    extends BasePage<FavoriteListCubit, FavoriteListState, FavoriteListEvent> {
  const FavoriteListPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, FavoriteListState state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: const [FavoriteProductsRoute(), FavoriteServicesRoute()],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: context.appBarColor,
            centerTitle: true,
            bottomOpacity: 1,
            title: Strings.bottomNavigationFavorite
                .w(500)
                .s(16)
                .c(context.textPrimary),
            leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: Assets.images.icArrowLeft.svg(),
            ),
            bottom: TabBar(
              physics: BouncingScrollPhysics(),
              indicator: MaterialIndicator(
                height: 6,
                tabPosition: TabPosition.bottom,
                topLeftRadius: 100,
                topRightRadius: 100,
                color: Color(0xFF5C6AC3),
                paintingStyle: PaintingStyle.fill,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Color(0xFF5C6AC3),
              unselectedLabelColor: context.textSecondary,
              indicatorColor: context.textPrimary,
              controller: controller,
              tabs: [
                Tab(text: Strings.favoriteProductTitle),
                Tab(text: Strings.favoriteServiceTitle),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
