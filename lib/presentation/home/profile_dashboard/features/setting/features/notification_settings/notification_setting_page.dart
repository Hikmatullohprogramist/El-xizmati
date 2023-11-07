import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/setting/features/notification_settings/cubit/notification_setting_cubit.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';

@RoutePage()
class NotificationSettingPage extends BasePage<NotificationSettingCubit,
    NotificationSettingBuildable, NotificationSettingListenable> {
  const NotificationSettingPage({super.key});

  @override
  Widget builder(BuildContext context, NotificationSettingBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Способ получения уведомления'
            .w(500)
            .s(14)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF5C6AC3)),
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
          )
        ],
      ),
    );
  }
}
