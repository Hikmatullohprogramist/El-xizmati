import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/button/common_button.dart';
import 'package:onlinebozor/common/widgets/action/selection_list_item.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/common/widgets/profile/profile_item_widget.dart';
import 'package:onlinebozor/presentation/home/features/profile/cubit/page_cubit.dart';

import '../../../../common/vibrator/vibrator_extension.dart';

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
      appBar: _buildAppBar(context),
      backgroundColor: Color(0xFFF2F4FB),
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
              _buildCardBlock(context, state),
              SizedBox(height: 8),
              _buildSettingsBlock(context, state),
              SizedBox(height: 8),
              _buildLogoutBlock(context, state),
            ],
          )),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Strings.profileViewTitlle.w(500).s(16).c(context.colors.textPrimary),
    );
  }

  /// Block builder methods

  Widget _buildProfileBlock(PageState state, BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: state.isLogin,
          child: ProfileItemWidget(
            name: Strings.profileTitle,
            icon: Assets.images.icUserAvatar,
            invoke: () {
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
            invoke: () {
              context.router.push(AuthStartRoute());
              vibrateAsHapticFeedback();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderBlock(
    BuildContext context,
    PageState state,
  ) {
    return Column(
      children: [
        Visibility(
          visible: state.isLogin,
          child: ProfileItemWidget(
            name: Strings.profileMyAds,
            icon: Assets.images.icProfileMyAds,
            invoke: () {
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
            invoke: () {
              context.router.push(UserOrderTypeRoute());
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
            invoke: () {
              context.router.push(PaymentTransactionRoute());
              vibrateAsHapticFeedback();
            },
          ),
        ),
        Visibility(
          visible: state.isLogin,
          child: SizedBox(height: 8),
        ),
      ],
    );
  }

  Widget _buildCardBlock(
    BuildContext context,
    PageState state,
  ) {
    return Column(
      children: [
        Visibility(
          visible: state.isLogin,
          child: ProfileItemWidget(
            name: Strings.profileMyCard,
            icon: Assets.images.icCard,
            invoke: () {
              context.router.push(UserCardsRoute());
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
            invoke: () {
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
          invoke: () {
            context.router.push(FavoritesRoute());
            vibrateAsHapticFeedback();
          },
        ),
      ],
    );
  }

  Widget _buildSettingsBlock(
    BuildContext context,
    PageState state,
  ) {
    return Column(
      children: [
        Visibility(
          visible: state.isLogin,
          child: ProfileItemWidget(
            name: Strings.profileSettings,
            icon: Assets.images.icProfileSettings,
            invoke: () {
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
          invoke: () {
            _showChangeLanguageBottomSheet(context);
            vibrateAsHapticFeedback();
          },
        ),
      ],
    );
  }

  Widget _buildLogoutBlock(
    BuildContext context,
    PageState state,
  ) {
    return Visibility(
        visible: state.isLogin,
        child: InkWell(
            onTap: () {
              _showLogoutBottomSheet(context);
              vibrateAsHapticFeedback();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Assets.images.icProfileLogout.svg(),
                      SizedBox(width: 16),
                      Strings.profileLogout.w(500).s(14).c(Color(0xFFF66412))
                    ],
                  ),
                  Assets.images.icArrowRight.svg(height: 16, width: 16)
                ],
              ),
            )));
  }

  /// Bottom sheet showing methods

  void _showChangeLanguageBottomSheet(BuildContext context) {
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
                isSelected: context.read<PageCubit>().states.language ==
                    Language.uzbekLatin,
                onClicked: (item) {
                  _saveSelectedLanguage(context, item);
                  context.router.pop();
                },
              ),
              CustomDivider(height: 2, startIndent: 20, endIndent: 20),
              SelectionListItem(
                item: Language.uzbekCyrill,
                title: Strings.languageUzCyr,
                isSelected: context.read<PageCubit>().states.language ==
                    Language.uzbekCyrill,
                onClicked: (item) {
                  _saveSelectedLanguage(context, item);
                  context.router.pop();
                },
              ),
              CustomDivider(height: 2, startIndent: 20, endIndent: 20),
              SelectionListItem(
                item: Language.russian,
                title: Strings.languageRus,
                isSelected: context.read<PageCubit>().states.language ==
                    Language.russian,
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
                    child: CommonButton(
                      color: Colors.blueAccent,
                      text: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Strings.commonNo.s(16).c(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        vibrateAsHapticFeedback();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CommonButton(
                      color: Colors.red,
                      text: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Strings.commonYes.s(16).c(Colors.white),
                      ),
                      onPressed: () {
                        context.read<PageCubit>().logOut();
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

    context.read<PageCubit>().selectLanguage(language, name);
  }
}
