import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_page.dart';
import 'cubit/ads_detail_cubit.dart';

@RoutePage()
class AdsDetailPage
    extends BasePage<AdsDetailCubit, AdsDetailBuildable, AdsDetailListenable> {
  const AdsDetailPage({super.key});

  @override
  Widget builder(BuildContext context, AdsDetailBuildable state) {
    return Scaffold(
        body: Center(
      child: Text("Auth Start"),
    ));
  }
}
