import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/home/cubit/home_cubit.dart';

import '../../common/gen/assets/assets.gen.dart';
import '../../common/router/app_router.dart';

@RoutePage()
class HomePage extends BasePage<HomeCubit, HomeBuildable, HomeListenable> {
  const HomePage({super.key});

  @override
  void init(BuildContext context) {
  context.read<HomeCubit>().isLogin();
  }

  @override
  Widget builder(BuildContext context, HomeBuildable state) {
    return AutoTabsRouter(
      routes: [
        DashboardRoute(),
        CategoryRoute(),
        FavoritesRoute(),
        CartRoute(),
        if (state.isLogin)
          ProfileDashboardRoute()
        else
          AuthStartRoute(backButtonVisible: false)
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
            bottomNavigationBar: Container(
              height: 80,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.50, color: Color(0xFFE5E9F3)),
                ),
              ),
              child: BottomNavigationBar(
                enableFeedback: true,
                type: BottomNavigationBarType.fixed,
                elevation: 1,
                selectedItemColor: const Color(0xFF5C6AC3),
                backgroundColor: Colors.white,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  // here we switch between tabs
                  tabsRouter.setActiveIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                      label: Strings.bottomNavigationHome,
                      tooltip: Strings.bottomNavigationHome,
                      icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.images.bottomBar.dashboard.svg()),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.dashboardActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: Strings.bottomNavigationCatolog,
                      icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.images.bottomBar.category.svg()),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.categoryActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: Strings.bottomNavigationFavorite,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.favorite.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.favoriteActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: Strings.bottomNavigationCart,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.cart.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.cartActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: Strings.bottomNavigationMore,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.profile.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.profileActive.svg(),
                      )),
                ],
              ),
            ));
      },
    );
  }
}
