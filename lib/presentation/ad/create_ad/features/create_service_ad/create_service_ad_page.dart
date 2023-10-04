import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/ad/create_ad/features/create_service_ad/cubit/create_service_ad_cubit.dart';

@RoutePage()
class CreateServiceAdPage extends BasePage<CreateServiceAdCubit,
    CreateServiceAdBuildable, CreateServiceAdListenable> {
  const CreateServiceAdPage({super.key});

  @override
  Widget builder(BuildContext context, CreateServiceAdBuildable state) {
    return Scaffold(
      body: Center(
        child: Text("Create Service Ad Page"),
      ),
    );
  }
}
