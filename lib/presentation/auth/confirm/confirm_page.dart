import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/auth/confirm/cubit/confirm_cubit.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/common_text_field.dart';

@RoutePage()
class ConfirmPage
    extends BasePage<ConfirmCubit, ConfirmBuildable, ConfirmListenable> {
  ConfirmPage(this.phone, this.confirmType, {super.key});

  final phone;
  final ConfirmType confirmType;
  final textEditingController = TextEditingController();
  final format = DateFormat("mm:ss");

  @override
  void init(BuildContext context) {
    context.read<ConfirmCubit>().setPhone(phone, confirmType);
    context.read<ConfirmCubit>().startTimer();
    textEditingController.text = phone;
  }

  @override
  void listener(BuildContext context, ConfirmListenable state) {
    switch (state.effect) {
      case ConfirmEffect.setPassword:
        context.router.replace(SetPasswordRoute());
    }
  }

  @override
  Widget builder(BuildContext context, ConfirmBuildable state) {
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
              context.router.pop();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 42),
            Strings.authConfirmCorfimationCode
                .w(500)
                .s(24)
                .c(context.colors.textPrimary),
            SizedBox(height: 42),
            Align(
                alignment: Alignment.centerLeft,
                child: Strings.commonPhoneNumber
                    .w(500)
                    .s(14)
                    .c(context.colors.textPrimary)),
            SizedBox(height: 10),
            Container(
                height: 56,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFFFAF9FF),
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
                      child: state.phone.w(500).s(14),
                    ),
                  ],
                )),
            SizedBox(height: 24),
            Align(
                alignment: Alignment.centerLeft,
                child: Strings.authConfirmSentSmsYourPhone(phone: phone)
                    .w(500)
                    .s(14)
                    .c(context.colors.textPrimary)
                    .copyWith(overflow: TextOverflow.ellipsis)),
            SizedBox(height: 10),
            CommonTextField(
              inputType: TextInputType.number,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                context.read<ConfirmCubit>().setCode(value);
              },
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonButton(
                    enabled: state.againButtonEnable,
                    onPressed: () => context.read<ConfirmCubit>().confirm(),
                    type: ButtonType.text,
                    child: Strings.authConfirmAgainSentSmsYourPhone
                        .w(500)
                        .s(14)
                        .c(Color(0xFF5C6AC3)),
                  ),
                ),
                format
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        state.timerTime * 1000))
                    .w(500)
                    .s(14)
                    .c(Colors.black)
              ],
            ),
            Spacer(),
            CommonButton(
              color: context.colors.buttonPrimary,
                onPressed: () {
                  context.read<ConfirmCubit>().confirm();
                },
                enabled: state.enable,
                loading: state.loading,
                child: Container(
                  height: 42,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Strings.commonContinueTitle
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimaryInverse),
                )),
            SizedBox(height: 20),
             Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:Strings.authPolicyAgree,
                    style: TextStyle(
                      color: Color(0xFF9EABBE),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.read<ConfirmCubit>().launchURLApp();
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

enum ConfirmType { confirm, recovery }
