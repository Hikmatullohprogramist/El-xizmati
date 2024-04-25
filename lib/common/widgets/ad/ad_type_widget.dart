import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../domain/models/ad/ad_type.dart';

class AdTypeWidget extends StatelessWidget {
  const AdTypeWidget({super.key, required this.adType});

  final AdType adType;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color(0xFF0096B2).withAlpha(200),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            (adType == AdType.PRODUCT
                    ? Strings.adTypeProductTitle
                    : Strings.adTypeServiceTitle)
                .w(400)
                .s(12)
                .c(context.colors.textPrimaryInverse)
                .copyWith(overflow: TextOverflow.ellipsis)
          ],
        ));
  }
}
