import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/gen/assets/assets.gen.dart';
import '../../common/router/app_router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      // list of your tab routes
      // routes used here must be declared as children
      // routes of /dashboard
      routes: const [
        DashboardRoute(),
        CategoryRoute(),
        FavoritesRoute(),
        CardRoute(),
        ProfileDashboardRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        // the passed child is technically our animated selected-tab page
        child: child,
      ),
      builder: (context, child) {
        // obtain the scoped TabsRouter controller using context
        final tabsRouter = AutoTabsRouter.of(context);
        // Here we're building our Scaffold inside of AutoTabsRouter
        // to access the tabsRouter controller provided in this context
        //
        //alterntivly you could use a global key
        return Scaffold(
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
                      label: 'Главная',
                      tooltip: 'Главная',
                      icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.images.bottomBar.dashboard.svg()),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.dashboardActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: 'Каталог',
                      icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.images.bottomBar.category.svg()),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.categoryActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: 'Желания',
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.favorite.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.favoriteActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: 'Корзина',
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.cart.svg(),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.cartActive.svg(),
                      )),
                  BottomNavigationBarItem(
                      label: 'Больше',
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
