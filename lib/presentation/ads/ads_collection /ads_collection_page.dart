import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_page.dart';
import 'cubit/ads_collection_cubit.dart';

@RoutePage()
class AdsCollectionPage extends BasePage<AdsCollectionCubit,
    AdsCollectionBuildable, AdsCollectionListenable> {
  const AdsCollectionPage(this.CollectiveType, {super.key});

  final CollectiveType;

  @override
  Widget builder(BuildContext context, AdsCollectionBuildable state) {
    return Center(
      child: Scaffold(
        body: Center(
          child: Text("Ads_collection"),
        ),
      ),
    );
  }
}
