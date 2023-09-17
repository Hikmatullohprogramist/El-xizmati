import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/auth/verification/cubit/verification_cubit.dart';

@RoutePage()
class VerificationPage extends BasePage<VerificationCubit,
    VerificationBuildable, VerificationListenable> {
  const VerificationPage({super.key});

  @override
  Widget builder(BuildContext context, VerificationBuildable state) {
    return Center();
  }
}
