import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/auth/register/cubit/register_cubit.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/common_text_field.dart';

@RoutePage()
class RegisterPage
    extends BasePage<RegisterCubit, RegisterBuildable, RegisterListenable> {
  RegisterPage(this.phone, {super.key});

  final phone;
  final textEditingController = TextEditingController();

  @override
  void init(BuildContext context) {
    context.read<RegisterCubit>().setPhone(phone);
    textEditingController.text = phone;
  }

  @override
  Widget builder(BuildContext context, RegisterBuildable state) {
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
            Strings.authVerification.w(500).s(24).c(context.colors.textPrimary),
            SizedBox(height: 42),
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
              enabled: false,
              controller: textEditingController,
              onChanged: (value) {
                context
                    .read<RegisterCubit>()
                    .setPhone(value.clearSpaceInPhone());
              },
              inputFormatters: textMaskFormatter,
            ),
            SizedBox(height: 24),
            Align(
                alignment: Alignment.centerLeft,
                child:
                    Strings.authConfirmSentSmsYourPhone(phone: "** *** ** 99")
                        .w(500)
                        .s(14)
                        .c(context.colors.textPrimary)),
            SizedBox(height: 10),
            CommonTextField(
              inputType: TextInputType.visiblePassword,
              readOnly: false,
              maxLines: 1,
              obscureText: true,
              onChanged: (value) {
                context.read<RegisterCubit>().setCode(value);
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonButton(
                onPressed: () {},
                type: ButtonType.text,
                child: Text(Strings.authConfirmAgainSentSmsYourPhone),
              ),
            ),
            Spacer(),
            CommonButton(
                onPressed: () {
                  context.read<RegisterCubit>().register();
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
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Авторизуясь, вы соглашаетесь с ',
                    style: TextStyle(
                      color: Color(0xFF9EABBE),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.67,
                      letterSpacing: 0.12,
                    ),
                  ),
                  TextSpan(
                    text: 'политикой \nобработки персональных данных ',
                    style: TextStyle(
                      color: Color(0xFF5C6AC3),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                      letterSpacing: 0.12,
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

var textMaskFormatter = MaskTextInputFormatter(
    mask: '(+998) ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);
