import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/ad/create_ad/cubit/create_ad_cubit.dart';

import '../../../common/core/base_page.dart';

@RoutePage()
class CreateAdPage
    extends BasePage<CreateAdCubit, CreateAdBuildable, CreateAdListenable> {
  const CreateAdPage({super.key});

  @override
  Widget builder(BuildContext context, CreateAdBuildable state) {
    return Scaffold(
      body: Center(child: Text("Create Ad")),
    );
  }
}
