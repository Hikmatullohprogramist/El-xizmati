import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/profile/profile_item_widget.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/cubit/profile_dashboard_cubit.dart';

@RoutePage()
class ProfileDashboardPage extends BasePage<ProfileDashboardCubit,
    ProfileDashboardBuildable, ProfileDashboardListenable> {
  const ProfileDashboardPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileDashboardBuildable state) {
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
              ProfileItemWidget(
                  name: state.isLogin
                      ? Strings.profileDahboardProfile
                      : Strings.authSinginTitle,
                  icon: Assets.images.profile.icUserAvatar
                      .svg(width: 18, height: 18),
                  invoke: () {
                    state.isLogin
                        ? context.router.push(ProfileViewerRoute())
                        : context.router.push(AuthStartRoute());
                  }),
              state.isLogin
                  ? Divider(indent: 46, height: 1)
                  : SizedBox(height: 24),
              Visibility(
                  visible: state.isLogin,
                  child: ProfileItemWidget(
                      name: Strings.profileDashboardMyAds,
                      icon: Assets.images.profile.icMegaPhone
                          .svg(width: 18, height: 18),
                      invoke: () => context.router.push(UserAdsRoute()))),
              Visibility(
                  visible: state.isLogin,
                  child: Divider(indent: 46, height: 1)),
              Visibility(
                  visible: state.isLogin,
                  child: ProfileItemWidget(
                      name: Strings.profileDashboardOrders,
                      icon: Assets.images.profile.icOrder
                          .svg(width: 18, height: 18),
                      invoke: () => context.router.push(UserOrdersRoute()))),
              // Divider(indent: 46, height: 1),
              // ProfileItemWidget(
              //     name: Strings.profileDahboardMessage,
              //     icon: Assets.images.profile.icMessage
              //         .svg(width: 18, height: 18),
              //     callback: () => context.router.push(ChatListRoute())),
              // Divider(indent: 46, height: 1),
              // ProfileItemWidget(
              //     name: Strings.profileDashboardNotification,
              //     icon: Assets.images.profile.icNotification
              //         .svg(width: 18, height: 18),
              //     callback: () => context.router.push(NotificationRoute())),
              Visibility(
                  visible: state.isLogin,
                  child: Divider(indent: 46, height: 1)),
              Visibility(
                  visible: state.isLogin,
                  child: ProfileItemWidget(
                      name: Strings.profileDashboardMyCard,
                      icon: Assets.images.profile.icCards
                          .svg(width: 18, height: 18),
                      invoke: () => context.router.push(UserCardsRoute()))),
              Visibility(
                  visible: state.isLogin,
                  child: Divider(indent: 46, height: 1)),
              Visibility(
                  visible: state.isLogin,
                  child: ProfileItemWidget(
                      name: Strings.profileDashboardPayment,
                      icon: Assets.images.profile.icPayment
                          .svg(width: 18, height: 18),
                      invoke: () =>
                          context.router.push(PaymentTransactionRoute()))),
              // Divider(indent: 46, height: 1),
              // ProfileItemWidget(
              //     name: Strings.profileDashboardComparison,
              //     icon: Assets.images.profile.icComparisonProduct
              //         .svg(width: 18, height: 18),
              //     callback: () => context.router.push(ComparisonDetailRoute())),
              Visibility(
                  visible: state.isLogin,
                  child: Divider(indent: 46, height: 1)),
              Visibility(
                  visible: state.isLogin,
                  child: ProfileItemWidget(
                      name: Strings.profileDashboardMyAddress,
                      icon: Assets.images.profile.icLocation
                          .svg(width: 18, height: 18),
                      invoke: () =>
                          context.router.push(UserAddressesRoute()))),
              // Divider(indent: 46, height: 1),
              // ProfileItemWidget(
              //     name: Strings.profileDashboardPromotions,
              //     icon: Assets.images.profile.icPromotion
              //         .svg(width: 18, height: 18),
              //     callback: () => context.router.push(PromotionRoute())),
              // Divider(indent: 46, height: 1),
              // ProfileItemWidget(
              //     name: Strings.profileDashboardSetting,
              //     icon: Assets.images.profile.icSetting
              //         .svg(width: 18, height: 18),
              //     callback: () => context.router.push(SettingRoute())),
              Visibility(
                visible: state.isLogin,
                child: Divider(indent: 46, height: 1),
              ),
              ProfileItemWidget(
                  name: Strings.profileDashboardChangeLanguage,
                  icon: Icon(
                    Icons.language,
                    color: context.colors.iconGrey,
                    size: 18,
                  ),
                  invoke: () => context.router.push(ChangeLanguageRoute())),
              Divider(indent: 46, height: 1),
              Visibility(
                  visible: state.isLogin,
                  child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              content: Text(Strings.profileLogoutDescription),
                              actions: [
                                TextButton(
                                  child: Text(Strings.commonNo),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(Strings.commonYes),
                                  onPressed: () {
                                    context
                                        .read<ProfileDashboardCubit>()
                                        .logOut();
                                    Navigator.of(dialogContext).pop();
                                    context.router.push(SetLanguageRoute());
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
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
                                Assets.images.profileViewer.icLogOut.svg(),
                                SizedBox(width: 16),
                                Strings.profileDashboardExit
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
}
