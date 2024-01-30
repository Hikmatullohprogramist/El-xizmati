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
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';
import 'package:onlinebozor/common/widgets/profile/profile_item_widget.dart';
import 'package:onlinebozor/presentation/home/features/profile/cubit/profile_cubit.dart';

@RoutePage()
class ProfilePage
    extends BasePage<ProfileCubit, ProfileBuildable, ProfileListenable> {
  const ProfilePage({super.key});

  @override
  void listener(BuildContext context, ProfileListenable state) {
    switch (state.effect) {
      case ProfileEffect.onLogOut:
        context.router.push(ProfileRoute());
    }
  }

  @override
  Widget builder(BuildContext context, ProfileBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Strings.profileViewTitlle
            .w(500)
            .s(16)
            .c(context.colors.textPrimary),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Visibility(
                visible: state.isLogin,
                child: ProfileItemWidget(
                  name: Strings.profileTitle,
                  icon: Assets.images.icUserAvatar,
                  invoke: () => context.router.push(ProfileViewRoute()),
                ),
              ),
              Visibility(
                visible: !state.isLogin,
                child: ProfileItemWidget(
                  name: Strings.authSinginTitle,
                  icon: Assets.images.icUserAvatar,
                  invoke: () => context.router.push(AuthStartRoute()),
                ),
              ),
              SizedBox(height: 8),
              Visibility(
                visible: state.isLogin,
                child: ProfileItemWidget(
                    name: Strings.profileMyAds,
                    icon: Assets.images.icProfileMyAds,
                    invoke: () => context.router.push(UserAdsRoute())),
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
                    invoke: () => context.router.push(UserOrderStartRoute())),
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
                    invoke: () =>
                        context.router.push(PaymentTransactionRoute())),
              ),
              Visibility(
                visible: state.isLogin,
                child: SizedBox(height: 8),
              ),
              Visibility(
                visible: state.isLogin,
                child: ProfileItemWidget(
                    name: Strings.profileMyCard,
                    icon: Assets.images.icCard,
                    invoke: () => context.router.push(UserCardsRoute())),
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
                    invoke: () => context.router.push(UserAddressesRoute())),
              ),
              Visibility(
                visible: state.isLogin,
                child: Divider(indent: 46, height: 1),
              ),
              ProfileItemWidget(
                name: Strings.bottomNavigationFavorite,
                icon: Assets.images.bottomBar.favorite,
                invoke: () => context.router.push(FavoritesRoute()),
              ),
              SizedBox(height: 8),
              Visibility(
                  visible: state.isLogin,
                  child: ProfileItemWidget(
                    name: Strings.profileSettings,
                    icon: Assets.images.icProfileSettings,
                    invoke: () => context.router.push(SettingRoute()),
                  )),
              Visibility(
                visible: state.isLogin,
                child: Divider(indent: 46, height: 1),
              ),
              ProfileItemWidget(
                name: Strings.profileChangeLanguage,
                icon: Assets.images.icProfileLanguage,
                invoke: () => _showChangeLanguageBottomSheet(context),
              ),
              SizedBox(height: 8),
              Visibility(
                  visible: state.isLogin,
                  child: InkWell(
                      onTap: () => _showLogoutBottomSheet(context),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                Strings.profileLogout
                                    .w(500)
                                    .s(14)
                                    .c(Color(0xFFF66412))
                              ],
                            ),
                            Assets.images.icArrowRight
                                .svg(height: 16, width: 16)
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }

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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 32),
              Center(child: Strings.languageSetTitle.s(20).w(600)),
              SizedBox(height: 24),
              InkWell(
                  onTap: () {
                    _saveSelectedLanguage(context, Language.uzbekLatin);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Strings.languageUzLat.w(500).s(16).c(Color(0xFF41455F)),
                        _getLanguageIcon(context, Language.uzbekLatin)
                      ],
                    ),
                  )),
              AppDivider(height: 2),
              InkWell(
                  onTap: () {
                    _saveSelectedLanguage(context, Language.uzbekCyrill);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Strings.languageUzCyr.w(500).s(16).c(Color(0xFF41455F)),
                        _getLanguageIcon(context, Language.uzbekCyrill)
                      ],
                    ),
                  )),
              AppDivider(height: 2),
              InkWell(
                  onTap: () {
                    _saveSelectedLanguage(context, Language.russian);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Strings.languageRus.w(500).s(16).c(Color(0xFF41455F)),
                        _getLanguageIcon(context, Language.russian)
                      ],
                    ),
                  )),
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
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Strings.commonNo.s(16).c(Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CommonButton(
                      color: Colors.red,
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Strings.commonYes.s(16).c(Colors.white),
                      ),
                      onPressed: () {
                        context.read<ProfileCubit>().logOut();

                        Navigator.pop(context);
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

    context.read<ProfileCubit>().selectLanguage(language, name);
  }

  SvgPicture _getLanguageIcon(BuildContext context, Language language) {
    return context.read<ProfileCubit>().buildable.language == language
        ? Assets.images.icRadioButtonSelected.svg(height: 20, width: 20)
        : Assets.images.icRadioButtonUnSelected.svg(height: 20, width: 20);
  }
}
