import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/profile_viewer/features/identified_page/cubit/identified_cubit.dart';

class IdentifiedPage extends BasePage<IdentifiedCubit, IdentifiedBuildable,
    IdentifiedListenable> {
  const IdentifiedPage({super.key});

  @override
  Widget builder(BuildContext context, IdentifiedBuildable state) {
    return Scaffold(
      body: Center(child: Text("Identified")),
    );
  }
}
