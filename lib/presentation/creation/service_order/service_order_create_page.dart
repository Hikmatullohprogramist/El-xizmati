import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../common/core/base_page.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import 'cubit/service_order_create_cubit.dart';

@RoutePage()
class ServiceOrderCreatePage extends BasePage<ServiceOrderCreateCubit, ServiceOrderCreateBuildable, ServiceOrderCreateListenable> {
  const ServiceOrderCreatePage({super.key});

  @override
  Widget builder(BuildContext context, ServiceOrderCreateBuildable state) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        bottomOpacity: 1,
        title: Strings.createRequestTitle.w(500).s(16).c(context.colors.textPrimary),
      ),
    );
  }
}
