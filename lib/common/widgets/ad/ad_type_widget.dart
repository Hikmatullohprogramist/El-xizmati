import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../enum/enums.dart';

class AppAdTypeWidget extends StatelessWidget {
  const AppAdTypeWidget({super.key, required this.adType});

  final AdType adType;

  @override
  Widget build(BuildContext context) {
    return switch (adType) {
      AdType.ads => Container(
          height: 20,
          width: 70,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFF0096B2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Mahsulot'.w(400).s(13).c(context.colors.textPrimaryInverse)],
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
            children: ['Xizmat'.w(400).s(13).c(context.colors.textPrimaryInverse)],
          ),
        ),
    };
  }
}
