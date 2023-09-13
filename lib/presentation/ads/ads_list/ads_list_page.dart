import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/base/base_page.dart';
import 'cubit/ads_list_cubit.dart';

@RoutePage()
class AdsListPage
    extends BasePage<AdsListCubit, AdsListBuildable, AdsListListenable> {
  const AdsListPage({super.key});

  @override
  Widget builder(BuildContext context, AdsListBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
