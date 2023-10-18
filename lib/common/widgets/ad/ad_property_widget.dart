import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../domain/model/ads/ad/ad_response.dart';
import '../../gen/localization/strings.dart';

class AppAdPropertyWidget extends StatelessWidget {
  const AppAdPropertyWidget(
      {super.key, required this.adsPropertyType, required this.isHorizontal});

  final PropertyStatus adsPropertyType;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(0x28AEB2CD)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            'статус:'.w(400).s(isHorizontal ? 10 : 12).c(Color(0xFF999CB2)),
            SizedBox(width: 5),
            switch (adsPropertyType) {
              PropertyStatus.NEW =>
                Strings.adsStatusNew.w(400).s(isHorizontal ? 10 : 12).c(Color(0xFF41455E)),
              PropertyStatus.USED =>
                Strings.adsStatusOld.w(400).s(isHorizontal ? 10 : 12).c(Color(0xFF41455E)),
            },
          ],
        ));
  }
}
