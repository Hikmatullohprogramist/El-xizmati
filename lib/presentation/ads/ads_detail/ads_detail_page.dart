import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/base/base_page.dart';
import 'cubit/ads_detail_cubit.dart';

@RoutePage()
class AdsDetailPage
    extends BasePage<AdsDetailCubit, AdsDetailBuildable, AdsDetailListenable> {
  const AdsDetailPage({super.key});

  @override
  Widget builder(BuildContext context, AdsDetailBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
