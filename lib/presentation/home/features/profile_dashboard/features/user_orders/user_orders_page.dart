import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/user_orders/cubit/user_orders_cubit.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../../../common/core/base_page.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';

@RoutePage()
class UserOrdersPage extends BasePage<UserOrdersCubit, UserOrdersBuildable,
    UserOrdersListenable> {
  const UserOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, UserOrdersBuildable state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: const [
        UserActiveOrdersRoute(),
        UserPendingOrdersRoute(),
        UserSavedOrdersRoute()
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            // actions: [
            //   CommonButton(
            //       type: ButtonType.text,
            //       onPressed: () => context.router.push(CreateAdRoute()),
            //       child: "Создать запрос".w(500).s(12).c(Color(0xFF5C6AC3)))
            // ],
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
            backgroundColor: Colors.white,
            centerTitle: true,
            bottomOpacity: 1,
            title: "Мои запросы".w(500).s(16).c(context.colors.textPrimary),
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
              tabs: const [
                Tab(text: 'Активные'),
                Tab(text: 'Ожидающие'),
                Tab(text: 'История'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
