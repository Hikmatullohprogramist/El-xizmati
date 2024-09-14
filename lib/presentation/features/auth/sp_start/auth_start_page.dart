
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/controller_exts.dart';
import 'package:El_xizmati/presentation/support/extensions/mask_formatters.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth_start_cubit.dart';

@RoutePage()
class AuthStartPage
    extends BasePage<AuthStartCubit, AuthStartState, AuthStartEvent> {
  AuthStartPage({super.key, this.phone});

  final String? phone;

  final TextEditingController _phoneController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setPhone(phone ?? "");
  }

  @override
  void onEventEmitted(BuildContext context, AuthStartEvent event) {
    switch (event.type) {
      case AuthStartEventType.onOTPConfirm:
        context.router.push(OtpConfirmationRoute(phoneNumber: event.phone??"",));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, AuthStartState state) {
    _phoneController.updateOnRestore(state.phone);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: context.backgroundWhiteColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.12),
                Assets.images.pngImages.appLogo.image(width: 64, height: 64),
                Text("el xizmati").w(700).s(32).c(Color(0xFF703EDB)),
                Text("ishchilar jamiyati").w(300).s(18).c(Color(0xFF2A174E)),
                SizedBox(height: 50),
                Text("Ro'yxatdan o'tish uchun telefon raqamingizni kiriting").w(700).s(18).c(Color(0xFF2A174E)).copyWith(textAlign: TextAlign.center),
                SizedBox(height: 55),
                LabelTextField(Strings.commonPhoneNumber, isRequired: false),
                SizedBox(height: 8),
                CustomTextFormField(
                  autofillHints: const [AutofillHints.telephoneNumber],
                  inputType: TextInputType.phone,
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  hint: Strings.commonPhoneNumber,
                  prefixText: "+998",
                  textInputAction: TextInputAction.done,
                  controller: _phoneController,
                  inputFormatters: phoneMaskFormatter,
                  onChanged: (value) {
                    cubit(context).setPhone(value);
                  },
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: (){
                        cubit(context).checkBox();
                      },
                      child: Container(height: 35,width: 35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(state.oriflameCheckBox)
                          Assets.spImages.svgImages.icCheckboxSelected.svg()
                          else
                          Assets.spImages.svgImages.icCheckboxUnselected.svg(),
                        ],
                      ),),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.authPricePoliceStart,
                              style: TextStyle(
                                color: context.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(text: " "),
                            TextSpan(
                              text: Strings.authPricePoliceAction,
                              style: TextStyle(
                                color: Color(0xFF5C6AC4),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  try {
                                    var url = Uri.parse(" ",);
                                    await launchUrl(url);
                                  } catch (error) {
                                    Logger().w("privacy policy launch error = $error");
                                  }
                                },
                            ),
                            TextSpan(text: " "),
                            TextSpan(
                              text: Strings.authPricePoliceEnd,
                              style: TextStyle(
                                color: context.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () {
                  cubit(context).authSendSMSCode();
                },
                backgroundColor: Color(0xFF703EDB).withAlpha(50),
                isEnabled: state.validation,
                isLoading: state.loading,
              ),
            ),
            SizedBox(height: 13),
            Container(height: 60,decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft:  Radius.circular(40),
                  ),
                  color: Color(0xFF703EDB)),
            )
          ],
        ),
      ),
    );
  }

}
