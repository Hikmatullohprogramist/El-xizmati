import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class SetPasswordPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SetPasswordPage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.navigationToHome:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: Strings.authRegisterRegister,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 42),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.authCommonPassword
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)),
              SizedBox(height: 10),
              CustomTextFormField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                maxLines: 1,
                onChanged: (value) {
                  cubit(context).setPassword(value);
                },
                // controller: textController,
              ),
              SizedBox(height: 24),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.authRegisterRepeatPassword
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)),
              SizedBox(height: 10),
              CustomTextFormField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                readOnly: false,
                maxLines: 1,
                obscureText: true,
                onChanged: (value) {
                  cubit(context).setRepeatPassword(value);
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextButton(
                  text: Strings.authRegisterPasswordContainLeastCharacters,
                  onPressed: () {},
                ),
              ),
              Spacer(),
              CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () {
                  TextInput.finishAutofillContext(shouldSave: true);
                  cubit(context).createPassword();
                },
                isEnabled: state.enabled,
                isLoading: state.loading,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
