import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import 'cubit/favorites_cubit.dart';

@RoutePage()
class FavoritesPage
    extends BasePage<FavoritesCubit, FavoritesBuildable, FavoritesListenable> {
  const FavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, FavoritesBuildable state) {
    return AutoTabsRouter.tabBar(
      routes: const [CommodityFavoritesRoute(), ServiceFavoritesRoute()],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Мои желания"),
            leading: AutoLeadingButton(),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: 'Товары'),
                Tab(text: 'Услуги'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
