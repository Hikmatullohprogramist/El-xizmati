import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/comparison_detail_cubit.dart';

@RoutePage()
class ComparisonDetailPage extends BasePage<ComparisonDetailCubit,
    ComparisonDetailBuildable, ComparisonDetailListenable> {
  const ComparisonDetailPage({super.key});

  @override
  Widget builder(BuildContext context, ComparisonDetailBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
