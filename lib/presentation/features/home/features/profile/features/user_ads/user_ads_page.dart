import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'cubit/user_ads_cubit.dart';

@RoutePage()
class UserAdsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserAdsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: [
        UserAdListRoute(userAdStatus: UserAdStatus.ALL),
        UserAdListRoute(userAdStatus: UserAdStatus.ACTIVE),
        UserAdListRoute(userAdStatus: UserAdStatus.WAIT),
        UserAdListRoute(userAdStatus: UserAdStatus.INACTIVE),
        UserAdListRoute(userAdStatus: UserAdStatus.CANCELLED),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              CustomTextButton(
                text: Strings.adCreateTitle,
                onPressed: () => context.router.push(CreateAdChooserRoute()),
              )
            ],
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
            backgroundColor: context.backgroundColor,
            centerTitle: true,
            bottomOpacity: 1,
            title:
                Strings.userAdsTitle.w(500).s(16).c(context.textPrimary),
            bottom: TabBar(
              isScrollable: true,
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
              unselectedLabelColor: context.textSecondary,
              indicatorColor: context.textPrimary,
              controller: controller,
              tabs: [
                Tab(text: Strings.userAdsAll),
                Tab(text: Strings.userAdsActive),
                Tab(text: Strings.userAdsWait),
                Tab(text: Strings.userAdsInactive),
                Tab(text: Strings.userAdsCancelled)
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
