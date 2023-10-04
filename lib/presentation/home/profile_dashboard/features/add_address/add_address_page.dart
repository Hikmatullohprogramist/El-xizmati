import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import 'cubit/add_address_cubit.dart';

@RoutePage()
class AddAddressPage extends BasePage<AddAddressCubit, AddAddressBuildable,
    AddAddressListenable> {
  const AddAddressPage({super.key});

  @override
  Widget builder(BuildContext context, AddAddressBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Мои адреса'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(child: Text("My address")),
    );
  }
}
