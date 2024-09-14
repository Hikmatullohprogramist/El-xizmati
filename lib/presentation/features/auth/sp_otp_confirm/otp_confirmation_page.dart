import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/colors/static_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_text_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'otp_confirmation_cubit.dart';

@RoutePage()
class OtpConfirmationPage extends BasePage<OtpConfirmationCubit,
    OtpConfirmationState, OtpConfirmationEvent> {
  final String phoneNumber;


  OtpConfirmationPage({
    super.key,
    required this.phoneNumber,
  });

  final textEditingController = TextEditingController();
  final format = DateFormat("mm:ss");

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(phoneNumber);
    cubit(context).startTimer();
    textEditingController.text = phoneNumber;
  }

  @override
  void onEventEmitted(BuildContext context, OtpConfirmationEvent event) {
    switch (event.type) {
      case OtpConfirmationEventType.onOpenResetPassword:
        context.router.pop();
      case OtpConfirmationEventType.onOpenRegistrationRoute:
        context.router.replace(RegistrationRoute(phoneNumber: phoneNumber));
      case OtpConfirmationEventType.onOpenHome:
        context.router.pushAndPopUntil(
          HomeRoute(), predicate: (Route<dynamic> route) => route is HomeRoute, // Stop at LoginPage
        );

    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, OtpConfirmationState state) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: context.backgroundWhiteColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Assets.images.pngImages.appLogo.image(width: 64, height: 64),
                SizedBox(width: 10),
                Column(children: [
                  Text("el xizmati").w(700).s(32).c(Color(0xFF703EDB)),
                  Text("ishchilar jamiyati").w(300).s(18).c(Color(0xFF2A174E)),
                ],)
              ],),
              SizedBox(height: 50),
              Text("Tasdiqlash kodi  +${state.phone} raqamingizga yuborildi").w(700).s(18).c(Color(0xFF2A174E)).copyWith(textAlign: TextAlign.center),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: pinCodeTextFieldWidget(context, cubit(context)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextButton(
                      textColor: Colors.black,
                      text: 'Kod qayta yuboriladi:',
                      isEnabled: state.isResentButtonEnabled,
                      isLoading: state.isResendLoading,
                      onPressed: () {},
                    ),
                  ),
                  format.format(DateTime.fromMillisecondsSinceEpoch(
                          state.timerTime * 1000,
                        ))
                      .w(500)
                      .s(14)
                      .c(Colors.black)
                ],
              ),
              Spacer(),
              CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () {
                  cubit(context).sendConfirmOtpCode();
                },
                isEnabled: state.isConfirmButtonEnabled,
                isLoading: state.isConfirmLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pinCodeTextFieldWidget(BuildContext context,OtpConfirmationCubit cubit) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      onChanged: (otp) {
        cubit.setCode(otp);
      },
      autoFocus: true,
      keyboardType: TextInputType.number,
      textStyle: TextStyle(
        color: context.textPrimary,
        fontFamily: 'Inter-VariableFont',
      ),
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        return true;
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        fieldHeight: 60,
        fieldWidth: 60,
        borderWidth: 0.1,
        borderRadius: BorderRadius.circular(16),
        activeColor: StaticColors.colorPrimary,
        inactiveColor: context.inputStrokeInactiveColor,
        // disabledColor: Colors.pink,
        selectedColor: context.inputStrokeInactiveColor,
        activeBorderWidth:1,
        inactiveBorderWidth:1,
        selectedBorderWidth: 2,
        /* activeBoxShadow: [
          BoxShadow(
            color: context.spgColor,
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],*/
        /*inActiveBoxShadow: [
          BoxShadow(
            color: context.spgColor,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],*/
      ),
      cursorColor: context.textPrimary.withOpacity(0.4),
      hintCharacter: '*',
      hintStyle: TextStyle(fontSize: 20, color: context.textPrimary.withOpacity(0.5)),
    );
  }

}
