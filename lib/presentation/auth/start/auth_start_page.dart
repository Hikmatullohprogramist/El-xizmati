import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/common/widgets/common_text_field.dart';
import 'package:onlinebozor/presentation/auth/confirm/confirm_page.dart';
import 'package:onlinebozor/presentation/auth/start/cubit/auth_start_cubit.dart';

import '../../util.dart';

@RoutePage()
class AuthStartPage
    extends BasePage<AuthStartCubit, AuthStartBuildable, AuthStartListenable> {
  AuthStartPage({super.key});

  @override
  void listener(BuildContext context, AuthStartListenable state) {
    switch (state.effect) {
      case AuthStartEffect.verification:
        context.router.push(VerificationRoute(phone: state.phone!));
      case AuthStartEffect.confirmation:
        context.router.push(ConfirmRoute(
            phone: state.phone!, confirmType: ConfirmType.confirm));
    }
  }

  @override
  void init(BuildContext context) {
    textEditingController.text = "+998 ";
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget builder(BuildContext context, AuthStartBuildable state) {
    return Scaffold(
      backgroundColor: context.colors.colorBackgroundPrimary,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: context.colors.iconGrey,
            ),
            onPressed: () {
              if (context.router.stack.length == 1) {
                exit(0);
              } else {
                context.router.pop();
              }
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Strings.authStartSingin.w(500).s(24).c(context.colors.textPrimary),
            Spacer(),
            Align(
                alignment: Alignment.centerLeft,
                child: Strings.commonPhoneNumber
                    .w(500)
                    .s(14)
                    .c(context.colors.textPrimary)),
            SizedBox(height: 10),
            CommonTextField(
              inputType: TextInputType.phone,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              controller: textEditingController,
              inputFormatters: phoneMaskFormatter,
              onChanged: (value) {
                context.read<AuthStartCubit>().setPhone(value);
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
                onPressed: () => context.router.replace(LoginWithOneIdRoute()),
                child: SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Strings.authStartLoginWithEds
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
                onPressed: () => context.router.replace(LoginWithOneIdRoute()),
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
                  context.read<AuthStartCubit>().validation();
                },
                enabled: state.validation,
                loading: state.loading,
                child: Container(
                  height: 42,
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
    );
  }
}
