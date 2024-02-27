import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/auth/eds/cubit/eds_cubit.dart';

@RoutePage()
class EdsPage extends BasePage<EdsCubit, EdsBuildable, EdsListenable> {
  const EdsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, EdsBuildable state) {
    return Scaffold();
  }
}
