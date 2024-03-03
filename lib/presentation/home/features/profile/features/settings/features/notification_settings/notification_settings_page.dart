import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/settings/features/notification_settings/cubit/page_cubit.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';

@RoutePage()
class NotificationSettingsPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const NotificationSettingsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Strings.settingsReceiveNotification
            .w(500)
            .s(14)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                    color: state.smsNotification
                        ? context.colors.primary
                        : context.colors.iconGrey),
              ),
              onPressed: () {
                cubit(context).setSmsNotification();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF5C6AC3)),
                    child: Center(child: Assets.images.icMessage.svg()),
                  ),
                  SizedBox(width: 16),
                  Strings.notificationReceiveSms
                      .w(600)
                      .s(14)
                      .c(Color(0xFF41455E))
                ]),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                    color: state.emailNotification
                        ? context.colors.primary
                        : context.colors.iconGrey),
              ),
              onPressed: () {
                cubit(context).setEmailNotification();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFDFE2E9), width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(child: Assets.images.icSms.svg()),
                  ),
                  SizedBox(width: 16),
                  Strings.notificationReceiveEmail
                      .w(600)
                      .s(14)
                      .c(Color(0xFF41455E))
                ]),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                    color: state.telegramNotification
                        ? context.colors.primary
                        : context.colors.iconGrey),
              ),
              onPressed: () {
                cubit(context).setTelegramNotification();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(children: [
                  Assets.images.icTelegram.svg(height: 32, width: 32),
                  // Container(
                  //   width: 32,
                  //   height: 32,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Color(0xFF00A4DD)),
                  //   child: Center(child: Assets.images.icSms.svg()),
                  // ),
                  SizedBox(width: 16),
                  Strings.notificationReceiveTelegram
                      .w(600)
                      .s(14)
                      .c(Color(0xFF41455E))
                ]),
              ),
            ),
            SizedBox(height: 12),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: Strings.telegramBotDescription,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF9EABBE))),
              WidgetSpan(
                  child: SizedBox(
                width: 5,
              )),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      cubit(context).openTelegram();
                    },
                  text: Strings.linkTitle,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF5C6AC3)))
            ])),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.commonSave,
                onPressed: () {},
              ),
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
