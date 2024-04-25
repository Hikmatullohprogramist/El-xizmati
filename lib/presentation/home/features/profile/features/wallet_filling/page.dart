import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/wallet_filling/cubit/page_cubit.dart';

import '../../../../../../common/widgets/app_bar/default_app_bar.dart';

@RoutePage()
class WalletFillingPage extends BasePage<PageCubit, PageState, PageEvent> {
  const WalletFillingPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "Пополнение кошелка",
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Center(
        child: Text("Wallet filling screen"),
      ),
    );
  }
}
