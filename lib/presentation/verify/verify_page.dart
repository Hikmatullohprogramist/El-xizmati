import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/common/widgets/common_text_field.dart';
import 'package:onlinebozor/presentation/verify/cubit/verify_cubit.dart';

@RoutePage()
class VerifyPage
    extends BasePage<VerifyCubit, VerifyBuildable, VerifyListenable> {
  const VerifyPage(this.phone, {Key? key}) : super(key: key);

  final String phone;

  @override
  void init(BuildContext context) {
    context.read<VerifyCubit>().setPhone(phone);
  }

  @override
  void listener(BuildContext context, VerifyListenable state) {
    switch (state.effect) {
      case VerifyEffect.success:
        context.router.push(HomeRoute());
        break;
    }
  }

  @override
  Widget builder(BuildContext context, VerifyBuildable state) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              CommonTextField(
                // label: Strings.authRegisterYear,
                onChanged: (code) {
                  context.read<VerifyCubit>().setCode(code);
                },
              ),
              SizedBox(height: 20),
              CommonButton(
                onPressed: () {
                  context.read<VerifyCubit>().verify();
                },
                loading: state.loading,
                enabled: state.enabled, child: Center(),
                // child: Strings.authVerifyVerify
                //     .s(18)
                //     .w(500)
                //     .c(context.colors.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
