import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';
import 'package:onlinebozor/presentation/widgets/profile/profile_item_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'profile_cubit.dart';

@RoutePage()
class ProfilePage extends BasePage<ProfileCubit, ProfileState, ProfileEvent> {
  const ProfilePage({super.key});

  @override
  void onEventEmitted(BuildContext context, ProfileEvent event) {
    switch (event.type) {
      case ProfileEventType.onLogOut:
        context.router.push(ProfileRoute());
    }
  }

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
            _buildProfileBlock(context, state),
            _buildOrderBlock(context, state),
            _buildCardBlock(context, state),
            _buildSettingsBlock(context, state),
            _buildLogoutBlock(context, state),
            _buildAppVersionBlock(),
          ],
        ),
      ),
    );
  }

  /// Block builder methods

  Widget _buildProfileBlock(BuildContext context, ProfileState state) {
    return ElevationWidget(
      topLeftRadius: 16,
      topRightRadius: 16,
      bottomLeftRadius: 16,
      bottomRightRadius: 16,
      leftMargin: 16,
      topMargin: 20,
      rightMargin: 16,
      bottomMargin: 8,
      child: Column(
        children: [
          Visibility(
            visible: state.isAuthorized,
            child: ProfileItemWidget(
              name: Strings.profileTitle,
              icon: Assets.images.icUserAvatar,
              topRadius: 16,
              bottomRadius: 16,
              onClicked: () {
                context.router.push(ProfileViewRoute());
                HapticFeedback.lightImpact();
              },
            ),
          ),
          Visibility(
            visible: !state.isAuthorized,
            child: ProfileItemWidget(
              name: Strings.authSinginTitle,
              icon: Assets.images.icUserAvatar,
              topRadius: 16,
              bottomRadius: 16,
              onClicked: () {
                context.router.push(AuthStartRoute());
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBlock(BuildContext context, ProfileState state) {
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
          Visibility(
            visible: state.isAuthorized,
            child: ProfileItemWidget(
              name: Strings.profileMyAds,
              icon: Assets.images.icProfileMyAds,
              topRadius: 16,
              onClicked: () {
                context.router.push(UserAdsRoute());
                HapticFeedback.lightImpact();
              },
            ),
          ),
          Visibility(
            visible: state.isAuthorized,
            child: Divider(indent: 46, height: 1),
          ),
          Visibility(
            visible: state.isAuthorized,
            child: ProfileItemWidget(
              name: Strings.profileOrders,
              icon: Assets.images.icProfileOrder,
              onClicked: () {
                // context.router.push(UserOrderTypeRoute());
                context.router.push(UserOrdersRoute(orderType: OrderType.buy));
                HapticFeedback.lightImpact();
              },
            ),
          ),
          Visibility(
            visible: state.isAuthorized,
            child: Divider(indent: 46, height: 1),
          ),
          Visibility(
            visible: state.isAuthorized,
            child: ProfileItemWidget(
              name: Strings.profilePayment,
              icon: Assets.images.icProfilePayment,
              bottomRadius: 16,
              onClicked: () {
                context.router.push(BillingTransactionsRoute());
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBlock(
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
          Visibility(
            visible: state.isAuthorized,
            child: ProfileItemWidget(
              name: Strings.profileMyCard,
              icon: Assets.images.icCard,
              topRadius: 16,
              onClicked: () {
                context.router.push(UserCardsRoute());
                HapticFeedback.lightImpact();
              },
            ),
          ),
          Visibility(
            visible: state.isAuthorized,
            child: Divider(indent: 46, height: 1),
          ),
          Visibility(
            visible: state.isAuthorized,
            child: ProfileItemWidget(
              name: Strings.profileMyAddress,
              icon: Assets.images.icProfileLocation,
              onClicked: () {
                context.router.push(UserAddressesRoute());
                HapticFeedback.lightImpact();
              },
            ),
          ),
          Visibility(
            visible: state.isAuthorized,
            child: Divider(indent: 46, height: 1),
          ),
          ProfileItemWidget(
            name: Strings.bottomNavigationFavorite,
            icon: Assets.images.bottomBar.favorite,
            topRadius: state.isAuthorized ? 0 : 16,
            bottomRadius: 16,
            onClicked: () {
              context.router.push(FavoriteListRoute());
              HapticFeedback.lightImpact();
            },
          ),
        ],
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
          Visibility(visible: false, child: Divider(indent: 46, height: 1)),
          ProfileItemWidget(
            name: Strings.profileChangeLanguage,
            icon: Assets.images.icProfileLanguage,
            topRadius: 16,
            bottomRadius: 16,
            onClicked: () {
              _showChangeLanguageBottomSheet(context, state);
              HapticFeedback.lightImpact();
            },
          ),
          Visibility(visible: false, child: Divider(indent: 46, height: 1)),
          Visibility(
            visible: false,
            child: ProfileItemWidget(
              name: Strings.profileDarkMode,
              icon: Assets.images.icProfileDarkMode,
              topRadius: 16,
              bottomRadius: 16,
              onClicked: () {
                _showChangeLanguageBottomSheet(context, state);
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutBlock(
    BuildContext context,
    ProfileState state,
  ) {
    return Visibility(
      visible: state.isAuthorized,
      child: ElevationWidget(
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
              name: Strings.profileLogout,
              icon: Assets.images.icProfileLogout,
              color: Color(0xFFF66412),
              topRadius: 16,
              bottomRadius: 16,
              onClicked: () {
                showYesNoBottomSheet(
                  context,
                  title: Strings.profileLogoutTitle,
                  message: Strings.profileLogoutDescription,
                  noTitle: Strings.commonNo,
                  onNoClicked: () {
                    Navigator.pop(context);
                    HapticFeedback.lightImpact();
                  },
                  yesTitle: Strings.commonYes,
                  onYesClicked: () async {
                    HapticFeedback.lightImpact();

                    await cubit(context).logOut();
                    Navigator.pop(context);
                  },
                );
                HapticFeedback.lightImpact();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppVersionBlock() {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        return Column(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 32,
                child: Assets.images.pngImages.appNameAndLogo.image(),
              ),
            ),
            "${snapshot.data!.version}(${snapshot.data!.buildNumber})"
                .s(14)
                .w(500),
            SizedBox(height: 32),
          ],
        );
      },
    );
  }

  /// Bottom sheet showing methods

  void _showChangeLanguageBottomSheet(
    BuildContext context,
    ProfileState state,
  ) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
              // color: context.bottomSheetColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 12),
                BottomSheetTitle(
                  title: Strings.languageSetTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                SizedBox(height: 16),
                SelectionListItem(
                  item: Language.uzbekLatin,
                  title: Strings.languageUzLat,
                  isSelected: state.language == Language.uzbekLatin,
                  onClicked: (item) {
                    _saveSelectedLanguage(context, item);
                    context.router.pop();
                  },
                ),
                CustomDivider(height: 2, startIndent: 20, endIndent: 20),
                SelectionListItem(
                  item: Language.uzbekCyrill,
                  title: Strings.languageUzCyr,
                  isSelected: state.language == Language.uzbekCyrill,
                  onClicked: (item) {
                    _saveSelectedLanguage(context, item);
                    context.router.pop();
                  },
                ),
                CustomDivider(height: 2, startIndent: 20, endIndent: 20),
                SelectionListItem(
                  item: Language.russian,
                  title: Strings.languageRus,
                  isSelected: state.language == Language.russian,
                  onClicked: (item) {
                    _saveSelectedLanguage(context, item);
                    context.router.pop();
                  },
                ),
                SizedBox(height: 32)
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveSelectedLanguage(BuildContext context, Language language) {
    Locale locale;
    String name;
    switch (language) {
      case Language.russian:
        locale = Locale('ru', 'RU');
        name = "ru";
        break;
      case Language.uzbekCyrill:
        locale = Locale('uz', 'UZK');
        name = "uzk";
        break;
      case Language.uzbekLatin:
        locale = Locale('uz', 'UZ');
        name = "uz";
        break;
    }

    EasyLocalization.of(context)?.setLocale(locale);

    cubit(context).selectLanguage(language, name);
  }
}
