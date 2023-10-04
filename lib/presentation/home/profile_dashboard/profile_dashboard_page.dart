import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/cubit/profile_dashboard_cubit.dart';

import '../../../common/widgets/profile/profile_item_widget.dart';

@RoutePage()
class ProfileDashboardPage extends BasePage<ProfileDashboardCubit,
    ProfileDashboardBuildable, ProfileDashboardListenable> {
  const ProfileDashboardPage({super.key});

  @override
  Widget builder(BuildContext context, ProfileDashboardBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 90,
        elevation: 0,
        actions: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Мой баланс:'.w(400).s(12).c(context.colors.textPrimary),
                      SizedBox(
                        height: 8,
                      ),
                      '250 000 сум'.w(700).s(16).c(context.colors.textPrimary),
                    ]),
              ),
              InkWell(
                onTap: ()=> context.router.push(WalletFillingRoute()),
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                padding: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Color(0xFFFAF9FE),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFFDFE2E9)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child:
                      'Пополнить кашелек'.w(500).c(context.colors.textPrimary),
                ),
              )),
            ],
          ))
        ],
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              ProfileItemWidget(
                  name: 'Профиль',
                  icon: Assets.images.profile.icUserAvatar
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(ProfileViewerRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Мои Объявления',
                  icon: Assets.images.profile.icMegaPhone
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(MyAdsRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Заказы',
                  icon:
                      Assets.images.profile.icOrder.svg(width: 18, height: 18),
                  callback: () => context.router.push(MyOrdersRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Сообщение',
                  icon: Assets.images.profile.icMessage
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(ChatListRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Уведомление',
                  icon: Assets.images.profile.icNotification
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(NotificationRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Мои карты',
                  icon:
                      Assets.images.profile.icCards.svg(width: 18, height: 18),
                  callback: () => context.router.push(MyCardsRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Платежи',
                  icon: Assets.images.profile.icPayment
                      .svg(width: 18, height: 18),
                  callback: () =>
                      context.router.push(PaymentTransactionRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Список сравнения',
                  icon: Assets.images.profile.icComparisonProduct
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(ComparisonDetailRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Мои адреса',
                  icon: Assets.images.profile.icLocation
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(AddAddressRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Продвижения',
                  icon: Assets.images.profile.icPromotion
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(PromotionRoute())),
              Divider(indent: 46, height: 1),
              ProfileItemWidget(
                  name: 'Настройки',
                  icon: Assets.images.profile.icSetting
                      .svg(width: 18, height: 18),
                  callback: () => context.router.push(SettingRoute())),
              Divider(indent: 46, height: 1),
              InkWell(
                  onTap: () {},
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
                            Assets.images.profileViewer.icLogOut.svg(),
                            SizedBox(width: 16),
                            "Выйти".w(500).s(14).c(Color(0xFFF66412))
                          ],
                        ),
                        Assets.images.icArrowRight.svg(height: 16, width: 16)
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
