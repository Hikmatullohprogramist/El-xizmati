import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinebozor/presentation/features/home/features/my_profile/profile_cubit.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

import '../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../core/gen/localization/strings.dart';
import '../../../../widgets/app_bar/empty_app_bar.dart';
import '../../../../widgets/elevation/elevation_widget.dart';
import '../../../../widgets/profile/profile_item_widget.dart';

@RoutePage()
class ProfilePage extends BasePage<ProfileCubit, ProfileState, ProfileEvent> {
  @override
  Widget onWidgetBuild(BuildContext context, ProfileState state) {
    return Scaffold(
      appBar: EmptyAppBar(
        titleText: Strings.profileViewTitlle,
        backgroundColor: context.appBarColor,
        textColor: context.textPrimary,
      ),
      backgroundColor: context.backgroundGreyColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSettingsBlock(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsBlock(
    BuildContext context,
    ProfileState state,
  ) {
    return ElevationWidget(
      topLeftRadius: 16,
      topRightRadius: 16,
      bottomLeftRadius: 16,
      bottomRightRadius: 16,
      leftMargin: 16,
      topMargin: 8,
      rightMargin: 16,
      bottomMargin: 8,
      child: Column(
        children: [
          ProfileItemWidget(
            name: Strings.profilePersonalData,
            icon: Assets.spImages.icProfileInfo,
            topRadius: 16,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.settingsChangePassword,
            icon: Assets.spImages.icProfileChangePassword,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.profileMyBalans,
            icon: Assets.spImages.icProfileBalance,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.profileNotification,
            icon: Assets.spImages.icProfileNotification,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.profileChangeLanguage,
            icon: Assets.spImages.icProfileLanguage,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          ProfileItemWidget(
            name: 'Yordam so’rash',
            icon: Assets.spImages.icProfileSupport,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: 'Ilova haqida',
            icon: Assets.spImages.icProfileIcon,
            topRadius: 0,
            bottomRadius: state.isAuthorized ? 0 : 16,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: 'Chiqish',
            icon: Assets.spImages.icProfileLogout,
            topRadius: 0,
            bottomRadius: state.isAuthorized ? 0 : 16,
            onClicked: () => {},
          ),
        ],
      ),
    );
  }
}
