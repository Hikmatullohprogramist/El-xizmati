import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_ads/features/inactive_ads/cubit/user_inactive_ads_cubit.dart';

import '../../../../../../../common/core/base_page.dart';
import '../../../../../../../common/widgets/ad_empty_widget.dart';

@RoutePage()
class UserInactiveAdsPage extends BasePage<UserInactiveAdsCubit,
    UserInactiveAdsBuildable, UserInactiveAdsListenable> {
  const UserInactiveAdsPage({super.key});

  @override
  Widget builder(BuildContext context, UserInactiveAdsBuildable state) {
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
