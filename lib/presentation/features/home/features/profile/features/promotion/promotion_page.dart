import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';

import 'cubit/promotion_cubit.dart';

@RoutePage()
class PromotionPage extends BasePage<PageCubit, PageState, PageEvent> {
  const PromotionPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Promotion Page")),
    );
  }
}
