import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/auth/confirm/cubit/page_cubit.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../common/widgets/button/common_button.dart';
import '../../../common/widgets/text_field/common_text_field.dart';

@RoutePage()
class ConfirmPage extends BasePage<PageCubit, PageState, PageEvent> {
  ConfirmPage({
    super.key,
    this.phone,
    required this.confirmType,
  });

  final phone;
  final ConfirmType confirmType;
  final textEditingController = TextEditingController();
  final format = DateFormat("mm:ss");

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(phone, confirmType);
    cubit(context).startTimer();
    textEditingController.text = phone;
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.setPassword:
        context.router.replace(SetPasswordRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.colors.colorBackgroundPrimary,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar("", () => context.router.pop()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 42),
            Strings.authConfirmCorfimationCode
                .w(500)
                .s(24)
                .c(context.colors.textPrimary),
            SizedBox(height: 42),
            Align(
              alignment: Alignment.centerLeft,
              child: Strings.commonPhoneNumber
                  .w(500)
                  .s(14)
                  .c(context.colors.textPrimary),
            ),
            SizedBox(height: 10),
            Container(
              height: 56,
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Color(0xFFFAF9FF),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFDFE2E9)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: state.phone.w(500).s(14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Strings.authConfirmSentSmsYourPhone(phone: phone)
                  .w(500)
                  .s(14)
                  .c(context.colors.textPrimary)
                  .copyWith(overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 10),
            CommonTextField(
              inputType: TextInputType.number,
              maxLines: 1,
              prefixText: "+998 ",
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                context.read<PageCubit>().setCode(value);
              },
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextButton(
                    text: Strings.authConfirmAgainSentSmsYourPhone,
                    isEnabled: state.isResentButtonEnabled,
                    isLoading: state.isResendLoading,
                    onPressed: () => cubit(context).resendCode(),
                  ),
                ),
                format
                    .format(
                      DateTime.fromMillisecondsSinceEpoch(
                        state.timerTime * 1000,
                      ),
                    )
                    .w(500)
                    .s(14)
                    .c(Colors.black)
              ],
            ),
            Spacer(),
            CommonButton(
              color: context.colors.buttonPrimary,
              onPressed: () {
                context.read<PageCubit>().confirmCode();
              },
              isEnabled: state.isConfirmButtonEnabled,
              isLoading: state.isConfirmLoading,
              text: Container(
                height: 52,
                alignment: Alignment.center,
                width: double.infinity,
                child: Strings.commonContinue
                    .w(500)
                    .s(14)
                    .c(context.colors.textPrimaryInverse),
              ),
            ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: Strings.authPolicyAgree,
                    style: TextStyle(
                      color: Color(0xFF9EABBE),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.read<PageCubit>().launchURLApp();
                      },
                    text: Strings.authPersonPolicy,
                    style: TextStyle(
                      color: Color(0xFF5C6AC3),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

enum ConfirmType { confirm, recovery }
