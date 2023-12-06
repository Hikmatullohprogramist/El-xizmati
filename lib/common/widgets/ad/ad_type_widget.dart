import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../enum/enums.dart';

class AppAdTypeWidget extends StatelessWidget {
  const AppAdTypeWidget({super.key, required this.adType});

  final AdType adType;

  @override
  Widget build(BuildContext context) {
    return switch (adType) {
      AdType.ads => Container(
        height: 20,
          width: 75,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFF0096B2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Strings.adTypeProductTitle
                  .w(400)
                  .s(12)
                  .c(context.colors.textPrimaryInverse)
                  .copyWith(overflow: TextOverflow.ellipsis)
            ],
          ),
        ),
      AdType.service => Container(
          height: 20,
          width: 64,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFF0096B2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Strings.adTypeServiceTitle
                  .w(400)
                  .s(13)
                  .c(context.colors.textPrimaryInverse)
                  .copyWith(overflow: TextOverflow.ellipsis)
            ],
          ),
        ),
    };
  }
}
