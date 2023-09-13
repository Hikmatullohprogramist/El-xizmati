import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/common/widgets/common_text_field.dart';
import 'package:onlinebozor/presentation/login/cubit/login_cubit.dart';

@RoutePage()
class LoginPage extends BasePage<LoginCubit, LoginBuildable, LoginListenable> {
   LoginPage({Key? key}) : super(key: key);

  @override
  void listener(BuildContext context, LoginListenable state) {
    switch (state.effect) {
      case LoginEffect.success:
        context.router.push(VerifyRoute(phone: state.phone!));
        break;
    }
  }

  @override
  Widget builder(BuildContext context, LoginBuildable state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              CommonTextField(
                label: Strings.authLoginPhone,
                onChanged: (phone) {
                  context.read<LoginCubit>().setPhone(phone);
                },
              ),
              SizedBox(height: 20),
              CommonButton(
                onPressed: () {
                  context.read<LoginCubit>().login();
                },
                loading: state.loading,
                enabled: state.enabled,
                child: Strings.authLoginLogin
                    .s(18)
                    .w(500)
                    .c(context.colors.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
