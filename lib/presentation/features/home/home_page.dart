import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class HomePage extends BasePage<PageCubit, PageState, PageEvent> {
  const HomePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return AutoTabsRouter(
      routes: [
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
              backgroundColor: context.bottomBarColor,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
                vibrateAsHapticFeedback();
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
                        valueListenable: Hive.box('cart_storage').listenable(),
                        builder: (BuildContext context, value, Widget? child) {
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
                        valueListenable: Hive.box('cart_storage').listenable(),
                        builder: (BuildContext context, value, Widget? child) {
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
