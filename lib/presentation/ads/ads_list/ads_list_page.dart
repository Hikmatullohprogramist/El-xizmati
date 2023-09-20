import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../common/core/base_page.dart';
import 'cubit/ads_list_cubit.dart';

@RoutePage()
class AdsListPage
    extends BasePage<AdsListCubit, AdsListBuildable, AdsListListenable> {
  const AdsListPage({required this.adsListType, super.key});

  final AdsListType adsListType;

  @override
  Widget builder(BuildContext context, AdsListBuildable state) {
    return Scaffold(
        body: Center(
      child: Text("Ads List"),
    ));
  }
}
