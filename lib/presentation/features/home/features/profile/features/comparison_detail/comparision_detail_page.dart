import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class ComparisonDetailPage extends BasePage<PageCubit, PageState, PageEvent> {
  const ComparisonDetailPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "",
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Center(child: Text("Comparison Detail Page")),
    );
  }
}
