import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/core/base_page.dart';
import 'cubit/ad_collection_cubit.dart';

@RoutePage()
class AdCollectionPage extends BasePage<AdCollectionCubit,
    AdCollectionBuildable, AdCollectionListenable> {
  const AdCollectionPage(this.collectiveType, {super.key});

  final CollectiveType collectiveType;

  @override
  Widget builder(BuildContext context, AdCollectionBuildable state) {
    return Center(
      child: Scaffold(
        body: Center(
          child:Center(child: Text("Collection  page")),
        ),
      ),
    );
  }
}
