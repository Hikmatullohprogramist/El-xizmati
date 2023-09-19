import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../gen/localization/strings.dart';

class AppAdsRouterWidget extends StatelessWidget {
  const AppAdsRouterWidget({
    super.key,
    required this.adsRouteType,
  });

  final AdsRouteType adsRouteType;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: switch (adsRouteType) {
              AdsRouteType.private => Color(0x28AEB2CD),
              AdsRouteType.business => Color(0x1E6546E7),
            }),
        child: switch (adsRouteType) {
          AdsRouteType.private =>
            Strings.adsPropertyPersonal.w(500).s(8).c(Color(0xFF999CB2)),
          AdsRouteType.business =>
            Strings.adsPropertyBiznes.w(500).s(8).c(Color(0xFF6546E7)),
        });
  }
}
