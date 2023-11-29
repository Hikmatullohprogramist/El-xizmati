import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/ad_empty_widget.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_ads/features/active_ads/cubit/user_active_ads_cubit.dart';

import '../../../../../../../common/core/base_page.dart';

@RoutePage()
class UserActiveAdsPage extends BasePage<UserActiveAdsCubit,
    UserActiveAdsBuildable, UserActiveAdsListenable> {
  const UserActiveAdsPage({super.key});

  @override
  Widget builder(BuildContext context, UserActiveAdsBuildable state) {
    return Scaffold(body: AdEmptyWidget(
      callBack: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.white,
            context: context,
            builder: (BuildContext buildContext) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                height: double.infinity,
              );
            });
      },
    ));
  }
}
