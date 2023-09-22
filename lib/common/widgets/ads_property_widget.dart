import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../domain/model/ads/ads_response.dart';
import '../gen/localization/strings.dart';

class AppAdsPropertyWidget extends StatelessWidget {
  AppAdsPropertyWidget({super.key, required this.adsPropertyType});

  final PropertyStatus adsPropertyType;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(0x28AEB2CD)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            'Holati:'.w(500).s(8).c(Color(0xFF999CB2)),
            SizedBox(width: 5),
            switch (adsPropertyType) {
              PropertyStatus.NEW =>
                Strings.adsStatusNew.w(500).s(8).c(Color(0xFF41455E)),
              PropertyStatus.USED =>
                Strings.adsStatusOld.w(500).s(8).c(Color(0xFF41455E)),
            },
          ],
        ));
  }
}
