import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/core/base_page.dart';
import 'cubit/ad_search_cubit.dart';

@RoutePage()
class AdSearchPage
    extends BasePage<AdSearchCubit, AdSearchBuildable, AdSearchListenable> {
  const AdSearchPage({super.key});

  @override
  Widget builder(BuildContext context, AdSearchBuildable state) {
    return Scaffold(
        body: Center(
      child: Text("Auth Start"),
    ));
  }
}
