import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/core/base_page.dart';
import 'cubit/create_ad_start_cubit.dart';

@RoutePage()
class CreateAdStartPage extends BasePage<CreateAdStartCubit, CreateAdStartBuildable, CreateAdStartListenable> {
  const CreateAdStartPage({super.key});

  @override
  Widget builder(BuildContext context, CreateAdStartBuildable state) {
    return Scaffold();
  }
}
