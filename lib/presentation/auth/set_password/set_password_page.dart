import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/auth/set_password/cubit/set_password_cubit.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/common_text_field.dart';

@RoutePage()
class SetPasswordPage extends BasePage<SetPasswordCubit, SetPasswordBuildable,
    SetPasswordListenable> {
  const SetPasswordPage({super.key});

  @override
  Widget builder(BuildContext context, SetPasswordBuildable state) {
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
            Strings.authRegister.w(500).s(24).c(context.colors.textPrimary),
            SizedBox(height: 42),
            Align(
                alignment: Alignment.centerLeft,
                child: Strings.authCommonPassword
                    .w(500)
                    .s(14)
                    .c(context.colors.textPrimary)),
            SizedBox(height: 10),
            CommonTextField(
              obscureText: true,
              inputType: TextInputType.visiblePassword,
              maxLines: 1,
              onChanged: (value) {
                context.read<SetPasswordCubit>().setPassword(value);
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
            CommonTextField(
              readOnly: false,
              maxLines: 1,
              obscureText: true,
              onChanged: (value) {
                context.read<SetPasswordCubit>().setRepeatPassword(value);
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonButton(
                onPressed: () {},
                type: ButtonType.text,
                child: Text(Strings.authRegisterPasswordContainLeastCharacters),
              ),
            ),
            Spacer(),
            CommonButton(
              onPressed: () {
                context.read<SetPasswordCubit>().createPassword();
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
          ],
        ),
      ),
    );
    ;
  }
}
