import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/common_button.dart';
import 'package:onlinebozor/common/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/common/widgets/text_field/common_text_field.dart';
import 'package:onlinebozor/presentation/auth/confirm/page.dart';
import 'package:onlinebozor/presentation/auth/start/cubit/page_cubit.dart';

import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../utils/mask_formatters.dart';

@RoutePage()
class AuthStartPage extends BasePage<PageCubit, PageState, PageEvent> {
  AuthStartPage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.verification:
        context.router.push(VerificationRoute(phone: event.phone!));
      case PageEventType.confirmation:
        context.router.push(
          ConfirmRoute(phone: event.phone!, confirmType: ConfirmType.confirm),
        );
    }
  }

  @override
  void onWidgetCreated(BuildContext context) {
    // phoneController.text = "+998 ";
  }

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.colors.colorBackgroundPrimary,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar("", () => context.router.pop()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Strings.authStartSingin
                  .w(500)
                  .s(24)
                  .c(context.colors.textPrimary),
              Spacer(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.commonPhoneNumber
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)),
              SizedBox(height: 10),
              CommonTextField(
                autofillHints: const [AutofillHints.telephoneNumber],
                inputType: TextInputType.phone,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                prefixText: "+998 ",
                textInputAction: TextInputAction.done,
                controller: phoneController,
                inputFormatters: phoneMaskFormatter,
                onChanged: (value) {
                  cubit(context).setPhone(value);
                },
              ),
              Spacer(),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithFaceId,
                onPressed: () {},
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.icFaceId.svg(),
              ),
              SizedBox(height: 10),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithOneId,
                onPressed: () => context.router.push(LoginWithOneIdRoute()),
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.icOneId.svg(),
              ),
              SizedBox(height: 10),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithMobileId,
                onPressed: () => context.router.push(LoginWithOneIdRoute()),
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.icOneId.svg(),
              ),
              SizedBox(height: 24),
              CommonButton(
                color: context.colors.buttonPrimary,
                onPressed: () {
                  cubit(context).validation();
                },
                isEnabled: state.validation,
                isLoading: state.loading,
                text: Container(
                  height: 52,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Strings.commonContinue
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimaryInverse),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
