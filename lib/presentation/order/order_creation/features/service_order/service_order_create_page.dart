import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../common/core/base_page.dart';
import 'cubit/service_order_create_cubit.dart';

@RoutePage()
class ServiceOrderCreatePage extends BasePage<ServiceOrderCreateCubit, ServiceOrderCreateBuildable, ServiceOrderCreateListenable> {
  const ServiceOrderCreatePage({super.key});

  @override
  Widget builder(BuildContext context, ServiceOrderCreateBuildable state) {
    return Scaffold();
  }
}
