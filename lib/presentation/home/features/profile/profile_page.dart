import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/common/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/common/widgets/profile/profile_item_widget.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/presentation/home/features/profile/cubit/page_cubit.dart';

import '../../../../common/colors/static_colors.dart';
import '../../../../common/vibrator/vibrator_extension.dart';
import '../../../../domain/models/language/language.dart';

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
      appBar: EmptyAppBar(Strings.profileViewTitlle),
      backgroundColor: StaticColors.backgroundColor,
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
                context.router.push(UserAdListRoute());
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
                context.router.push(
                  UserOrderListRoute(orderType: OrderType.buy),
                );
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
            visible: state.isLogin,
            child: ProfileItemWidget(
              name: Strings.profileMyCard,
              icon: Assets.images.icCard,
              onClicked: () {
                context.router.push(UserCardListRoute());
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
          Visibility(
            visible: state.isLogin,
            child: Divider(indent: 46, height: 1),
          ),
          ProfileItemWidget(
            name: Strings.profileChangeLanguage,
            icon: Assets.images.icProfileLanguage,
            onClicked: () {
              _showChangeLanguageBottomSheet(context, state);
              vibrateAsHapticFeedback();
            },
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
            color: Colors.white,
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 32),
              Center(child: Strings.profileLogoutTitle.s(22).w(600)),
              SizedBox(height: 24),
              Center(child: Strings.profileLogoutDescription.s(16)),
              SizedBox(height: 32),
              Row(
                children: <Widget>[
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomOutlinedButton(
                      text: Strings.commonNo,
                      strokeColor: Colors.blueAccent,
                      onPressed: () {
                        Navigator.pop(context);
                        vibrateAsHapticFeedback();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomOutlinedButton(
                      text: Strings.commonYes,
                      strokeColor: Colors.red,
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
