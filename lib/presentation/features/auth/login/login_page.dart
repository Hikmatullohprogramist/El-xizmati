import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/otp/otp_confirm_type.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/controller_exts.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_text_button.dart';
import 'package:El_xizmati/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/label_text_field.dart';
import 'package:El_xizmati/presentation/widgets/form_field/validator/password_validator.dart';

import 'login_cubit.dart';

@RoutePage()
class LoginPage extends BasePage<LoginCubit, LoginState, LoginEvent> {
  LoginPage(this.phoneNumber, {super.key});

  final String phoneNumber;

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(phoneNumber.clearPhoneWithCode());
    _phoneController.text = phoneNumber.clearPhoneWithCode();
  }

  @override
  void onEventEmitted(BuildContext context, LoginEvent event) {
    Logger().w("onEventEmitted event = $event");
    switch (event.type) {
      case LoginEventType.onOpenHome:
        context.router.replace(HomeRoute());
      case LoginEventType.onOpenResetPassword:
        context.router.replace(OtpConfirmationRoute(
          phoneNumber: phoneNumber,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, LoginState state) {
    _passwordController.updateOnRestore(state.password);

    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: Strings.authStartSingin,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () {
          context.router.replace(AuthStartRoute(phone: state.phone));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                LabelTextField(Strings.commonPhoneNumber, isRequired: false),
                SizedBox(height: 8),
                CustomTextFormField(
                  autofillHints: const [AutofillHints.telephoneNumber],
                  enabled: false,
                  readOnly: true,
                  maxLines: 1,
                  prefixText: "+998",
                  label: state.phone,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16),
                LabelTextField(Strings.authCommonPassword, isRequired: false),
                SizedBox(height: 8),
                CustomTextFormField(
                  autofillHints: const [AutofillHints.password],
                  enableSuggestions: true,
                  inputType: TextInputType.visiblePassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  readOnly: false,
                  maxLines: 1,
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) => PasswordValidator.validate(value),
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
                SizedBox(height: 16),
                CustomElevatedButton(
                  text: Strings.commonContinue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      TextInput.finishAutofillContext(shouldSave: true);
                      cubit(context).login();
                    }
                  },
                  isLoading: state.isRequestSending,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
