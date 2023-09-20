import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/profile_viewer_cubit.dart';

@RoutePage()
class ProfileViewerPage extends BasePage<ProfileViewerCubit,
    ProfileViewerBuildable, ProfileViewerListenable> {
  const ProfileViewerPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileViewerBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
