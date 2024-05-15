import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/presentation/widgets/profile/profile_item_widget.dart';

import 'cubit/profile_cubit.dart';

@RoutePage()
class ProfilePage extends BasePage<PageCubit, PageState, PageEvent> {
  const ProfilePage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onLogOut:
        context.router.push(ProfileRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: EmptyAppBar(
        titleText: Strings.profileViewTitlle,
        backgroundColor: context.backgroundColor,
      ),
      backgroundColor: context.backgroundColor,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              _buildProfileBlock(state, context),
              SizedBox(height: 8),
              _buildOrderBlock(context, state),
              SizedBox(height: 8),
              _buildCardBlock(context, state),
              SizedBox(height: 8),
              _buildSettingsBlock(context, state),
              SizedBox(height: 8),
              _buildLogoutBlock(context, state),
            ],
          )),
    );
  }

  /// Block builder methods

  Widget _buildProfileBlock(PageState state, BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Visibility(
            visible: state.isLogin,
            child: ProfileItemWidget(
              name: Strings.profileTitle,
              icon: Assets.images.icUserAvatar,
              onClicked: () {
                context.router.push(ProfileViewRoute());
                vibrateAsHapticFeedback();
              },
            ),
          ),
          Visibility(
            visible: !state.isLogin,
            child: ProfileItemWidget(
              name: Strings.authSinginTitle,
              icon: Assets.images.icUserAvatar,
              onClicked: () {
                context.router.push(AuthStartRoute());
                vibrateAsHapticFeedback();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Visibility(
            visible: state.isLogin,
            child: ProfileItemWidget(
              name: Strings.profileMyAds,
              icon: Assets.images.icProfileMyAds,
              onClicked: () {
                context.router.push(UserAdsRoute());
                vibrateAsHapticFeedback();
              },
            ),
          ),
          Visibility(
            visible: state.isLogin,
            child: Divider(indent: 46, height: 1),
          ),
          Visibility(
            visible: state.isLogin,
            child: ProfileItemWidget(
              name: Strings.profileOrders,
              icon: Assets.images.icProfileOrder,
              onClicked: () {
                // context.router.push(UserOrderTypeRoute());
                context.router.push(UserOrdersRoute(orderType: OrderType.buy));
                vibrateAsHapticFeedback();
              },
            ),
          ),
          Visibility(
            visible: state.isLogin,
            child: Divider(indent: 46, height: 1),
          ),
          Visibility(
            visible: state.isLogin,
            child: ProfileItemWidget(
              name: Strings.profilePayment,
              icon: Assets.images.icProfilePayment,
              onClicked: () {
                context.router.push(PaymentTransactionRoute());
                vibrateAsHapticFeedback();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Visibility(
            // visible: state.isLogin,
            visible: false,
            child: ProfileItemWidget(
              name: Strings.profileMyCard,
              icon: Assets.images.icCard,
              onClicked: () {
                context.router.push(UserCardsRoute());
                vibrateAsHapticFeedback();
              },
            ),
          ),
          Visibility(
            // visible: state.isLogin,
            visible: false,
            child: Divider(indent: 46, height: 1),
          ),
          Visibility(
            visible: state.isLogin,
            child: ProfileItemWidget(
              name: Strings.profileMyAddress,
              icon: Assets.images.icProfileLocation,
              onClicked: () {
                context.router.push(UserAddressesRoute());
                vibrateAsHapticFeedback();
              },
            ),
          ),
          Visibility(
            visible: state.isLogin,
            child: Divider(indent: 46, height: 1),
          ),
          ProfileItemWidget(
            name: Strings.bottomNavigationFavorite,
            icon: Assets.images.bottomBar.favorite,
            onClicked: () {
              context.router.push(FavoriteListRoute());
              vibrateAsHapticFeedback();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Visibility(
            visible: false,
            child: ProfileItemWidget(
              name: Strings.profileSettings,
              icon: Assets.images.icProfileSettings,
              onClicked: () {
                context.router.push(SettingRoute());
                vibrateAsHapticFeedback();
              },
            ),
          ),
          Visibility(visible: false, child: Divider(indent: 46, height: 1)),
          ProfileItemWidget(
            name: Strings.profileChangeLanguage,
            icon: Assets.images.icProfileLanguage,
            onClicked: () {
              _showChangeLanguageBottomSheet(context, state);
              vibrateAsHapticFeedback();
            },
          ),
          Visibility(visible: false, child: Divider(indent: 46, height: 1)),
          Visibility(
            visible: false,
            child: ProfileItemWidget(
              name: Strings.profileDarkMode,
              icon: Assets.images.icProfileDarkMode,
              onClicked: () {
                _showChangeLanguageBottomSheet(context, state);
                vibrateAsHapticFeedback();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutBlock(
    BuildContext context,
    PageState state,
  ) {
    return Visibility(
      visible: state.isLogin,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ProfileItemWidget(
              name: Strings.profileLogout,
              icon: Assets.images.icProfileLogout,
              color: Color(0xFFF66412),
              onClicked: () {
                _showLogoutBottomSheet(context);
                vibrateAsHapticFeedback();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom sheet showing methods

  void _showChangeLanguageBottomSheet(BuildContext context, PageState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: context.backgroundColor,
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
        );
      },
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 12),
              BottomSheetTitle(
                title: Strings.profileLogoutTitle,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              // Center(child: Strings.profileLogoutTitle.s(22).w(600)),
              SizedBox(height: 24),
              Center(child: Strings.profileLogoutDescription.s(16)),
              SizedBox(height: 32),
              Row(
                children: <Widget>[
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      text: Strings.commonNo,
                      // backgroundColor: Colors.blueAccent.shade200,
                      onPressed: () {
                        Navigator.pop(context);
                        vibrateAsHapticFeedback();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      text: Strings.commonYes,
                      backgroundColor: Color(0xFFEB2F69),
                      onPressed: () {
                        cubit(context).logOut();
                        Navigator.pop(context);
                        vibrateAsHapticFeedback();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 24),
            ],
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
