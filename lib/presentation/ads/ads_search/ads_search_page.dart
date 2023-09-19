import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_page.dart';
import 'cubit/ads_search_cubit.dart';

@RoutePage()
class AdsSearchPage
    extends BasePage<AdsSearchCubit, AdsSearchBuildable, AdsSearchListenable> {
  const AdsSearchPage({super.key});

  @override
  Widget builder(BuildContext context, AdsSearchBuildable state) {
    return Scaffold(
        body: Center(
      child: Text("Auth Start"),
    ));
  }
}
