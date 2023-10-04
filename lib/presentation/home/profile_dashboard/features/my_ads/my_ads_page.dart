import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/my_ads/cubit/my_ads_cubit.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/common_button.dart';

@RoutePage()
class MyAdsPage extends BasePage<MyAdsCubit, MyAdsBuildable, MyAdsListenable> {
  const MyAdsPage({super.key});

  @override
  Widget builder(BuildContext context, MyAdsBuildable state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: const [
        MyActiveAdsRoute(),
        MyPendingAdsRoute(),
        MyInactiveAdsRoute()
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              CommonButton(
                  type: ButtonType.text,
                  onPressed: () => context.router.push(CreateAdRoute()),
                  child: "Добавить товар".w(500).s(12).c(Color(0xFF5C6AC3)))
            ],
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
            backgroundColor: Colors.white,
            centerTitle: true,
            bottomOpacity: 1,
            title: "Объявления".w(500).s(16).c(context.colors.textPrimary),
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
                Tab(text: 'Нет в наличии'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
