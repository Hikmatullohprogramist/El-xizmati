import 'package:flutter/cupertino.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

import '../../../domain/models/ad/ad_type.dart';

class AdTypeWidget extends StatelessWidget {
  final AdType adType;

  const AdTypeWidget({
    super.key,
    required this.adType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(6),
        ),
        color: Color(0xFF0096B2).withOpacity(0.9),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          (adType == AdType.product
                  ? Strings.adTypeProductTitle
                  : Strings.adTypeServiceTitle)
              .w(400)
              .s(12)
              .c(context.textPrimaryInverse)
              .copyWith(overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
