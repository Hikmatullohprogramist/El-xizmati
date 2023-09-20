import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/common/widgets/common_text_field.dart';

import 'cubit/login_cubit.dart';

@RoutePage()
class LoginPage extends BasePage<LoginCubit, LoginBuildable, LoginListenable> {
  LoginPage(this.phone, {Key? key}) : super(key: key);

  final String phone;
  var textController = TextEditingController();

  @override
  void init(BuildContext context) {
    context.read<LoginCubit>().setPhone(phone);
    textController.text = phone;
  }

  @override
  void listener(BuildContext context, LoginListenable state) {
    switch (state.effect) {
      case LoginEffect.success:
        context.router.push(HomeRoute());
    }
  }

  @override
  Widget builder(BuildContext context, LoginBuildable state) {
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
            Strings.authStartSingin.w(500).s(24).c(context.colors.textPrimary),
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
              controller: textController,
            ),
            SizedBox(height: 24),
            Align(
                alignment: Alignment.centerLeft,
                child: Strings.authCommonPassword
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
                context.read<LoginCubit>().setPassword(value);
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonButton(
                onPressed: () {},
                type: ButtonType.text,
                child: Text(Strings.authVerificationForgetPassword),
              ),
            ),
            Spacer(),
            CommonButton(
              onPressed: () {
                context.read<LoginCubit>().login();
              },
              enabled: state.enabled,
              loading: state.loading,
              child: Container(
                height: 42,
                alignment: Alignment.center,
                width: double.infinity,
                child: Strings.commonContinueTitle
                    .w(500)
                    .s(14)
                    .c(context.colors.textPrimaryInverse),
              ),
            ),
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
