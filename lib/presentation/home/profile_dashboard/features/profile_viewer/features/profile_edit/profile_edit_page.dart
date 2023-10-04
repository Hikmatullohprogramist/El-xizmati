import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/profile_viewer/features/profile_edit/cubit/profile_edit_cubit.dart';

import '../../../../../../../common/base/base_page.dart';
import '../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../common/widgets/common_button.dart';

@RoutePage()
class ProfileEditPage extends BasePage<ProfileEditCubit, ProfileEditBuildable,
    ProfileEditListenable> {
  const ProfileEditPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileEditBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Изменить'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          CommonButton(
              type: ButtonType.text,
              onPressed: () {},
              child: "Сохранить".w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(child: Text("Profile Edit Screen")),
    );
  }
}
