import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'cubit/chats_cubit.dart';

@RoutePage()
class ChatsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const ChatsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: const [
        BuyingChatsRoute(),
        SellingChatsRoute(),
        SavedChatsRoute()
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
            backgroundColor: context.backgroundColor,
            centerTitle: true,
            bottomOpacity: 1,
            title: "Сообщение".w(500).s(16).c(context.colors.textPrimary),
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
                Tab(text: 'Продаю'),
                Tab(text: 'Покупаю'),
                Tab(text: 'Сохраненные'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
