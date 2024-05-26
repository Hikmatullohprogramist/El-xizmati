import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/profile/profile_item_widget.dart';

import 'cubit/settings_cubit.dart';

@RoutePage()
class SettingPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SettingPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.backgroundColor,
          title:
              Strings.settingsTitle.w(500).s(14).c(context.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                name: Strings.settingsReceiveNotification,
                icon: Assets.images.icProfileNotification,
                onClicked: () =>
                    context.router.push(NotificationSettingsRoute()),
              ),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                name: Strings.settingsSocialNetwork,
                icon: Assets.images.icSocialNetwork,
                onClicked: () {
                  // context.router.push(UserSocialNetworkRoute())
                },
              ),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                name: Strings.settingsActiveDevices,
                icon: Assets.images.icActiveDevice,
                onClicked: () => context.router.push(UserActiveSessionsRoute()),
              ),
              // Divider(indent: 46, height: 1),
              // ProfileItemWidget(
              //   name: Strings.settingsChangePassword,
              //   icon: Assets.images.icChangePassword,
              //   invoke: () {},
              // )
            ],
          ),
        ));
  }
}
