import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/common/common_text_field.dart';
import 'package:onlinebozor/presentation/auth/confirm/confirm_page.dart';
import 'package:onlinebozor/presentation/auth/start/cubit/auth_start_cubit.dart';

import '../../../common/widgets/app_bar/common_app_bar.dart';
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
      appBar: CommonAppBar("", () => context.router.pop()),
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
                  context.read<PageCubit>().setPhone(value);
                },
              ),
              Spacer(),
              CommonButton(
                  color: context.colors.borderColor,
                  type: ButtonType.outlined,
                  onPressed: () {},
                  child: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Strings.authStartLoginWithFaceId
                            .w(400)
                            .s(14)
                            .c(context.colors.textPrimary),
                        Assets.images.icFaceId.svg()
                      ],
                    ),
                  )),
              SizedBox(height: 10),
              CommonButton(
                  color: context.colors.borderColor,
                  type: ButtonType.outlined,
                  onPressed: () =>
                      context.router.replace(LoginWithOneIdRoute()),
                  child: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Strings.authStartLoginWithOneId
                            .w(400)
                            .s(14)
                            .c(context.colors.textPrimary),
                        Assets.images.icOneId.svg()
                      ],
                    ),
                  )),
              SizedBox(height: 10),
              CommonButton(
                  color: context.colors.borderColor,
                  type: ButtonType.outlined,
                  onPressed: () =>
                      context.router.replace(LoginWithOneIdRoute()),
                  child: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Strings.authStartLoginWithMobileId
                            .w(400)
                            .s(14)
                            .c(context.colors.textPrimary),
                        Assets.images.icOneId.svg()
                      ],
                    ),
                  )),
              SizedBox(height: 24),
              CommonButton(
                  color: context.colors.buttonPrimary,
                  onPressed: () {
                    context.read<PageCubit>().validation();
                  },
                  enabled: state.validation,
                  loading: state.loading,
                  child: Container(
                    height: 52,
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Strings.commonContinueTitle
                        .w(500)
                        .s(14)
                        .c(context.colors.textPrimaryInverse),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
