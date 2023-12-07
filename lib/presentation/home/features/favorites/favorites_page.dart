import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'cubit/favorites_cubit.dart';

@RoutePage()
class FavoritesPage
    extends BasePage<FavoritesCubit, FavoritesBuildable, FavoritesListenable> {
  const FavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, FavoritesBuildable state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: const [ProductFavoritesRoute(), ServiceFavoritesRoute()],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            centerTitle: true,
            bottomOpacity: 1,
            title: Strings.favoriteTitle
                .w(500)
                .s(16)
                .c(context.colors.textPrimary),
            leading: AutoLeadingButton(),
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
              unselectedLabelColor: Color(0xFF9EABBE),
              indicatorColor: context.colors.textPrimary,
              controller: controller,
              tabs: [
                Tab(text: Strings.favoriteCommodityTitle),
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
