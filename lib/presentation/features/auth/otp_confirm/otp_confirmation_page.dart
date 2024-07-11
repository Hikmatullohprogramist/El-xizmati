import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/faceid/face_id_confirm_type.dart';
import 'package:onlinebozor/domain/models/otp/otp_confirm_type.dart';
import 'package:onlinebozor/presentation/features/auth/face_id/confirmation/face_id_confirmation_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';

import 'otp_confirmation_cubit.dart';

@RoutePage()
class OtpConfirmationPage extends BasePage<OtpConfirmationCubit,
    OtpConfirmationState, OtpConfirmationEvent> {
  final String phoneNumber;
  final String sessionToken;
  final OtpConfirmType confirmType;

  OtpConfirmationPage({
    super.key,
    required this.phoneNumber,
    required this.sessionToken,
    required this.confirmType,
  });

  final textEditingController = TextEditingController();
  final format = DateFormat("mm:ss");

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(phoneNumber, sessionToken, confirmType);
    cubit(context).startTimer();
    textEditingController.text = phoneNumber;
  }

  @override
  void onEventEmitted(BuildContext context, OtpConfirmationEvent event) {
    switch (event.type) {
      case OtpConfirmationEventType.onOpenResetPassword:
        context.router.replace(ResetPasswordRoute());
      case OtpConfirmationEventType.onOpenIdentityVerification:
        context.router.replace(FaceIdConfirmationRoute(
          secretKey: cubit(context).states.secretKey,
          faceIdConfirmType: FaceIdConfirmType.forRegister,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, OtpConfirmationState state) {
    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: Strings.authConfirmCorfimationCode,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child:
                  Strings.commonPhoneNumber.w(500).s(14).c(context.textPrimary),
            ),
            SizedBox(height: 10),
            Container(
              height: 56,
              width: double.infinity,
              decoration: ShapeDecoration(
                color: context.inputBackgroundColor,
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
                    child: "+998 ${state.phone}".w(500).s(14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Strings.authConfirmSentSmsYourPhone(phone: phoneNumber)
                  .w(500)
                  .s(14)
                  .c(context.textPrimary)
                  .copyWith(overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              inputType: TextInputType.number,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                cubit(context).setEnteredOtpCode(value);
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
            CustomElevatedButton(
              text: Strings.commonContinue,
              onPressed: () {
                cubit(context).confirmCode();
              },
              isEnabled: state.isConfirmButtonEnabled,
              isLoading: state.isConfirmLoading,
            ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: Strings.authPolicyAgree,
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        cubit(context).launchURLApp();
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
