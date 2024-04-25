import 'dart:io' as favorite_list_page;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class FavoriteListPage extends BasePage<PageCubit, PageState, PageEvent> {
  const FavoriteListPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: const [FavoriteProductsRoute(), FavoriteServicesRoute()],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: context.backgroundColor,
            centerTitle: true,
            bottomOpacity: 1,
            title: Strings.bottomNavigationFavorite
                .w(500)
                .s(16)
                .c(context.colors.textPrimary),
            // leading: AutoLeadingButton(),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: context.colors.iconGrey),
              onPressed: () {
                if (context.router.stack.length == 1) {
                  favorite_list_page.exit(0);
                } else {
                  context.router.pop();
                }
              },
            ),
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
                Tab(text: Strings.favoriteProductTitle),
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
