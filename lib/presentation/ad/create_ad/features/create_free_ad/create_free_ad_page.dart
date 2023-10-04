import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/ad/create_ad/features/create_free_ad/cubit/create_free_ad_cubit.dart';

@RoutePage()
class CreateFreeAdPage extends BasePage<CreateFreeAdCubit,
    CreateFreeAdBuildable, CreateFreeAdListenable> {
  const CreateFreeAdPage({super.key});

  @override
  Widget builder(BuildContext context, CreateFreeAdBuildable state) {
    return Scaffold(
      body: Center(child: Text("Create Free Ad Page")),
    );
  }
}
