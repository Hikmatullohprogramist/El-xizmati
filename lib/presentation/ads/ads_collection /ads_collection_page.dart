import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/base/base_page.dart';
import 'cubit/ads_collection_cubit.dart';

@RoutePage()
class AdsCollectionPage extends BasePage<AdsCollectionCubit,
    AdsCollectionBuildable, AdsCollectionListenable> {
  const AdsCollectionPage({super.key});

  @override
  Widget builder(BuildContext context, AdsCollectionBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}
