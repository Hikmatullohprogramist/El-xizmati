import 'package:auto_route/annotations.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/auth/set_password/cubit/set_password_cubit.dart';

@RoutePage()
class SetPasswordPage extends BasePage<SetPasswordCubit, SetPasswordBuildable,
    SetPasswordListenable> {
   SetPasswordPage({super.key});

  @override
  Widget builder(BuildContext context, SetPasswordBuildable state) {
    // TODO: implement builder
    throw UnimplementedError();
  }
}
