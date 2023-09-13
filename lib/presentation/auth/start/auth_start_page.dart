import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/auth/start/cubit/auth_start_cubit.dart';

@RoutePage()
class AuthStartPage
    extends BasePage<AuthStartCubit, AuthStartBuildable, AuthStartListenable> {
  const AuthStartPage({super.key});

  @override
  Widget builder(BuildContext context, AuthStartBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
