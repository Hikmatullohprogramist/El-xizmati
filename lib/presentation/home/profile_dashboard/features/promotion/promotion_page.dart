import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/promotion/cubit/promotion_cubit.dart';

import '../../../../../common/core/base_page.dart';

@RoutePage()
class PromotionPage
    extends BasePage<PromotionCubit, PromotionBuildable, PromotionListenable> {
  const PromotionPage({super.key});

  @override
  Widget builder(BuildContext context, PromotionBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Promotion Page")),
    );
  }
}
