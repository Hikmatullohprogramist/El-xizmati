import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';
import 'cubit/my_social_network_cubit.dart';

@RoutePage()
class MySocialNetworkPage extends BasePage<MySocialNetworkCubit,
    MySocialNetworkBuildable, MySocialNetworkListenable> {
  const MySocialNetworkPage({super.key});

  @override
  Widget builder(BuildContext context, MySocialNetworkBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Мои соц.сети'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(
        child: Text("My Social Network page"),
      ),
    );
  }
}
