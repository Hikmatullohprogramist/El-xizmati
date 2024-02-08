import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/home/cubit/home_cubit.dart';

import '../../common/core/base_page.dart';
import '../../common/gen/assets/assets.gen.dart';
import '../../common/router/app_router.dart';

@RoutePage()
class HomePage extends BasePage<HomeCubit, HomeBuildable, HomeListenable> {
  const HomePage({super.key});

  @override
  Widget builder(BuildContext context, HomeBuildable state) {
    return AutoTabsRouter(
      routes: const [
        DashboardRoute(),
        CategoryRoute(),
        CreateAdChooserRoute(),
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
                  // if (index < 2) {
                  //   tabsRouter.setActiveIndex(index);
                  // }
                  // if (index == 2) {
                  //   context.router.push(FavoritesRoute());
                  tabsRouter.setActiveIndex(index);
                  // } else {
                  //   tabsRouter.setActiveIndex(index);
                  // }
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
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: Strings.bottomNavigationCatalog,
                    icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.images.bottomBar.category.svg()),
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
                          .svg(height: 20, width: 20),
                    ),
                    // activeIcon: Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Assets.images.bottomBar.categoryActive.svg(),
                    // ),
                  ),
                  BottomNavigationBarItem(
                      label: Strings.bottomNavigationCart,
                      icon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box('cart_storage').listenable(),
                          builder:
                              (BuildContext context, value, Widget? child) {
                            int cartNumber = Hive.box("cart_storage").length;
                            return Badge(
                              textStyle: TextStyle(fontSize: 8),
                              alignment: Alignment.topRight,
                              isLabelVisible: cartNumber > 0,
                              label: cartNumber.toString().w(500),
                              child: Assets.images.bottomBar.cart.svg(),
                            );
                          },
                        ),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box('cart_storage').listenable(),
                          builder:
                              (BuildContext context, value, Widget? child) {
                            int cartNumber = Hive.box("cart_storage").length;
                            return Badge(
                              textStyle: TextStyle(fontSize: 8),
                              alignment: Alignment.topRight,
                              isLabelVisible: cartNumber > 0,
                              label: cartNumber.toString().w(500),
                              child: Assets.images.bottomBar.cartActive.svg(),
                            );
                          },
                        ),
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
