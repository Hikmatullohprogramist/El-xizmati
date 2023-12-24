import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../common/core/base_page.dart';
import 'cubit/a_cubit.dart';

@RoutePage()
class ZZPage extends BasePage<ZZCubit, ZZBuildable, ZZListenable> {
  const ZZPage({super.key});

  @override
  Widget builder(BuildContext context, ZZBuildable state) {
    return Scaffold();
  }
}
