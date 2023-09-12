import 'package:auto_route/annotations.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/auth/confirm/cubit/auth_confirm_cubit.dart';

@RoutePage()
class AuthConfirmPage
    extends BasePage<AuthConfirmCubit, AuthBuildable, AuthListenable> {
  const AuthConfirmPage({super.key});

  @override
  Widget builder(BuildContext context, AuthBuildable state) {
    // TODO: implement builder
    throw UnimplementedError();
  }
}
