import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/common_button.dart';
import 'cubit/profile_viewer_cubit.dart';

@RoutePage()
class ProfileViewerPage extends BasePage<ProfileViewerCubit,
    ProfileViewerBuildable, ProfileViewerListenable> {
  const ProfileViewerPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileViewerBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Профиль'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          CommonButton(
              type: ButtonType.text,
              onPressed: () {},
              child: "Изменить".w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Личные данные".w(700).c(Color(0xFF41455E)).s(16),
              ],
            )
          ],
        ),
      ),
    );
  }
}
