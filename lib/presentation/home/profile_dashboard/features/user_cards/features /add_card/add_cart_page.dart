import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_cards/features%20/add_card/cubit/add_card_cubit.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';

@RoutePage()
class AddCardPage
    extends BasePage<AddCardCubit, AddCardBuildable, AddCardListenable> {
  const AddCardPage({super.key});

  @override
  Widget builder(BuildContext context, AddCardBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'добавить карту'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(
        child: Text("Add Card"),
      ),
    );
  }
}
