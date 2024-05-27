import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/features/auth/confirm/auth_confirm_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/password_validator.dart';

import 'cubit/auth_login_cubit.dart';

@RoutePage()
class AuthLoginPage extends BasePage<PageCubit, PageState, PageEvent> {
  AuthLoginPage(this.phone, {super.key});

  final String phone;

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setPhone(phone.clearPhoneWithCode());
    _phoneController.text = phone.clearPhoneWithCode();
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    Logger().w("onEventEmitted event = $event");
    switch (event.type) {
      case PageEventType.onOpenHome:
        context.router.replace(HomeRoute());
      case PageEventType.onOpenAuthConfirm:
        context.router.replace(
          AuthConfirmRoute(phone: phone, confirmType: ConfirmType.recovery),
        );
      case PageEventType.onLoginFailed:
        showErrorBottomSheet(context, event.message ?? "");
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    _passwordController.updateOnRestore(state.password);

    return Scaffold(
        backgroundColor: context.colors.backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: DefaultAppBar(
          titleText: Strings.authStartSingin,
          titleTextColor: context.textPrimary,
          backgroundColor: context.backgroundColor,
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
                    prefixText: "998 ",
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
        ));
  }
}
