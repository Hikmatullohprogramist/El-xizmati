import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';

import '../../../../../common/router/app_router.dart';
import 'cubit/user_cards_cubit.dart';

@RoutePage()
class UserCardsPage
    extends BasePage<UserCardsCubit, UserCardsBuildable, UserCardsListenable> {
  const UserCardsPage({super.key});

  @override
  Widget builder(BuildContext context, UserCardsBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Мои карты'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0,
        actions: [
          CommonButton(
              type: ButtonType.text,
              onPressed: () => context.router.push(AddCardRoute()),
              child: "Добавить".w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(
        child: Text("User card"),
      ),
    );
  }
}
