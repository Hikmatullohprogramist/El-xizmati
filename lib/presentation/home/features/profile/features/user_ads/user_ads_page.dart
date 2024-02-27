import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_ads/cubit/user_ads_cubit.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../domain/models/ad/user_ad_status.dart';

@RoutePage()
class UserAdsPage
    extends BasePage<UserAdsCubit, UserAdsBuildable, UserAdsListenable> {
  const UserAdsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, UserAdsBuildable state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes:  [
        UserAdListRoute(userAdStatus: UserAdStatus.all),
        UserAdListRoute(userAdStatus: UserAdStatus.active),
        UserAdListRoute(userAdStatus: UserAdStatus.wait),
        UserAdListRoute(userAdStatus: UserAdStatus.inactive),
        UserAdListRoute(userAdStatus: UserAdStatus.canceled),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              CommonButton(
                  type: ButtonType.text,
                  onPressed: () => context.router.push(CreateAdStartRoute()),
                  child:
                      Strings.adCreateTitle.w(500).s(12).c(Color(0xFF5C6AC3)))
            ],
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
            backgroundColor: Colors.white,
            centerTitle: true,
            bottomOpacity: 1,
            title:
                Strings.userAdsTitle.w(500).s(16).c(context.colors.textPrimary),
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
              unselectedLabelColor: Color(0xFF9EABBE),
              indicatorColor: context.colors.textPrimary,
              controller: controller,
              tabs: [
                Tab(text: Strings.userAdsAllTitle),
                Tab(text: Strings.userAdsActiveTitle),
                Tab(text: Strings.userAdsPendingTitle),
                Tab(text: Strings.userAdsInactiveTitle),
                Tab(text: Strings.userAdsCanceledTitle)
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
