import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/auth/confirm/cubit/confirm_cubit.dart';

@RoutePage()
class ConfirmPage
    extends BasePage<ConfirmCubit, ConfirmBuildable, ConfirmListenable> {
  const ConfirmPage({super.key});

  @override
  Widget builder(BuildContext context, ConfirmBuildable state) {
    return Center(
      child: Text("ConfirmPage"),
    );
  }
}
