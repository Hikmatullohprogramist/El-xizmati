import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import '../../enum/AdRouteType.dart';
import '../../gen/localization/strings.dart';

class AppAdRouterWidget extends StatelessWidget {
  const AppAdRouterWidget(
      {super.key, required this.adRouteType, required this.isHorizontal});

  final AdRouteTypeses adRouteType;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: switch (adRouteType) {
              AdRouteTypeses.PRIVATE => Color(0x28AEB2CD),
              AdRouteTypeses.BUSINESS => Color(0x1E6546E7),
            }),
        child: switch (adRouteType) {
          AdRouteTypeses.PRIVATE => Strings.adsPropertyPersonal
              .w(400)
              .s(isHorizontal ? 10 : 12)
              .c(Color(0xFF999CB2)),
          AdRouteTypeses.BUSINESS => Strings.adsPropertyBiznes
              .w(400)
              .s(isHorizontal ? 10 : 12)
              .c(Color(0xFF6546E7)),
        });
  }
}
