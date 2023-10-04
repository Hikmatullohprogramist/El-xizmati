import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/ad/create_ad/features/create_product_ad/cubit/create_product_ad_cubit.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<CreateProductAdCubit,
    CreateProductAdBuildable, CreateProductAdListenable> {
  const CreateProductAdPage({super.key});

  @override
  Widget builder(BuildContext context, CreateProductAdBuildable state) {
    return Scaffold(
      body: Center(child: Text("Create Product Ad Page")),
    );
  }
}
