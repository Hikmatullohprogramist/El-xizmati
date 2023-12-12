import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/setting/cubit/setting_cubit.dart';

import '../../../../../../common/core/base_page.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../common/router/app_router.dart';
import '../../../../../../common/widgets/profile/profile_item_widget.dart';

@RoutePage()
class SettingPage
    extends BasePage<SettingCubit, SettingBuildable, SettingListenable> {
  const SettingPage({super.key});

  @override
  Widget builder(BuildContext context, SettingBuildable state) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              Strings.settingsTitle.w(500).s(14).c(context.colors.textPrimary),
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
                icon: Assets.images.profileViewer.icNotification.svg(),
                invoke: () => context.router.push(NotificationSettingRoute()),
              ),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                name: Strings.settingsSocialNetwork,
                icon: Assets.images.profileViewer.icNetwork.svg(),
                invoke: () => context.router.push(UserSocialNetworkRoute()),
              ),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                name: Strings.settingsActiveDevices,
                icon: Assets.images.profileViewer.icActiveDevice.svg(),
                invoke: () => context.router.push(UserActiveDeviceRoute()),
              ),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                name: Strings.settingsChangePassword,
                icon: Assets.images.profileViewer.icChangePassword.svg(),
                invoke: () {},
              )
            ],
          ),
        ));
  }
}
