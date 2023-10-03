import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/setting/cubit/setting_cubit.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/router/app_router.dart';
import '../../../../../common/widgets/profile/profile_item_widget.dart';

@RoutePage()
class SettingPage
    extends BasePage<SettingCubit, SettingBuildable, SettingListenable> {
  const SettingPage({super.key});

  @override
  Widget builder(BuildContext context, SettingBuildable state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: 'Настройки'.w(500).s(14).c(context.colors.textPrimary),
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
              Container(color: Color(0xFFF6F7FC), height: 12),
              ProfileItemWidget(
                name: 'Способ получения уведомления',
                icon: Assets.images.profileViewer.icNotification.svg(),
                callback: () {},
              ),
              Container(color: Color(0xFFF6F7FC), height: 12),
              ProfileItemWidget(
                name: 'Мои соц.сети',
                icon: Assets.images.profileViewer.icNetwork.svg(),
                callback: () => context.router.push(MySocialNetworkRoute()),
              ),
              Container(color: Color(0xFFF6F7FC), height: 12),
              ProfileItemWidget(
                name: 'Активные сеансы',
                icon: Assets.images.profileViewer.icActiveDevice.svg(),
                callback: () => context.router.push(MyActiveDeviceRoute()),
              ),
              Container(color: Color(0xFFF6F7FC), height: 12),
              ProfileItemWidget(
                name: 'Поменять пароль',
                icon: Assets.images.profileViewer.icChangePassword.svg(),
                callback: () {},
              ),
              Container(color: Color(0xFFF6F7FC), height: 12)
            ],
          ),
        ));
  }
}
