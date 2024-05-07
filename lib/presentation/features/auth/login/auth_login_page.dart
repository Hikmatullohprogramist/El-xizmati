import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/features/auth/confirm/auth_confirm_page.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'cubit/page_cubit.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';

@RoutePage()
class AuthLoginPage extends BasePage<PageCubit, PageState, PageEvent> {
  AuthLoginPage(this.phone, {super.key});

  final String phone;
  final textEditingController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setPhone(phone.clearPhoneWithCode());
    textEditingController.text = phone.clearPhoneWithCode();
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.navigationHome:
        context.router.replace(HomeRoute());
      case PageEventType.navigationToConfirm:
        context.router.replace(
          AuthConfirmRoute(phone: phone, confirmType: ConfirmType.recovery),
        );
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
        backgroundColor: context.colors.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: context.backgroundColor,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: context.colors.iconGrey,
              ),
              onPressed: () {
                context.router.replace(AuthStartRoute(phone: state.phone));
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 42),
                Strings.authStartSingin
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
                CustomTextFormField(
                  autofillHints: const [AutofillHints.telephoneNumber],
                  enabled: false,
                  readOnly: true,
                  maxLines: 1,
                  prefixText: "998 ",
                  label: state.phone,
                  onChanged: (value) {},
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.authCommonPassword
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary),
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  autofillHints: const [AutofillHints.password],
                  enableSuggestions: true,
                  inputType: TextInputType.visiblePassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  readOnly: false,
                  maxLines: 1,
                  obscureText: true,
                  onChanged: (value) {
                    cubit(context).setPassword(value);
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextButton(
                    text: Strings.authVerificationForgetPassword,
                    onPressed: () => cubit(context).forgetPassword(),
                  ),
                ),
                Spacer(),
                CustomElevatedButton(
                  text: Strings.commonContinue,
                  onPressed: () {
                    TextInput.finishAutofillContext(shouldSave: true);
                    cubit(context).login();
                  },
                  isEnabled: state.enable,
                  isLoading: state.loading,
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
        ));
  }
}
