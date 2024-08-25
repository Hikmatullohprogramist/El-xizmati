import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/platform_sizes.dart';

import 'home_cubit.dart';

@RoutePage()
class HomePage extends BasePage<HomeCubit, HomeState, HomeEvent> {
  const HomePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, HomeState state) {
    return AutoTabsRouter(
      routes: [
        DashboardRoute(),
        CategoryRoute(),
        AdCreationChooserRoute(),
        CartRoute(),
        ProfileRoute()
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            elevation: 1,
            selectedItemColor: const Color(0xFF5C6AC3),
            backgroundColor: context.bottomBarColor,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: [
              BottomNavigationBarItem(
                label: Strings.bottomNavigationHome,
                tooltip: Strings.bottomNavigationHome,
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.dashboard.svg(),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.dashboardActive.svg(),
                ),
              ),
              BottomNavigationBarItem(
                label: Strings.bottomNavigationCatalog,
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.category.svg(),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.categoryActive.svg(),
                ),
              ),
              BottomNavigationBarItem(
                label: Strings.bottomNavigationAddAd,
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.addAd
                      .svg(height: 22, width: 22),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.addAdActive.svg(),
                ),
              ),
              BottomNavigationBarItem(
                label: Strings.bottomNavigationCart,
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Badge(
                    textStyle: TextStyle(fontSize: 8),
                    alignment: Alignment.topRight,
                    isLabelVisible: state.cartAdsCount > 0,
                    label: state.cartAdsCount.toString().w(500),
                    child: Assets.images.bottomBar.cart.svg(),
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Badge(
                    textStyle: TextStyle(fontSize: 8),
                    alignment: Alignment.topRight,
                    isLabelVisible: state.cartAdsCount > 0,
                    label: state.cartAdsCount.toString().w(500),
                    child: Assets.images.bottomBar.cartActive.svg(),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: Strings.bottomNavigationProfile,
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.profile.svg(),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.images.bottomBar.profileActive.svg(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
