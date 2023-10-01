import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/profile_edit_cubit.dart';

@RoutePage()
class ProfileEditPage extends BasePage<ProfileEditCubit, ProfileEditBuildable,
    ProfileEditListenable> {
  const ProfileEditPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileEditBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
