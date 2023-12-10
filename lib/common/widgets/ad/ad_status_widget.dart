import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../domain/util.dart';
import '../../gen/assets/assets.gen.dart';

class AppAdStatusWidget extends StatelessWidget {
  const AppAdStatusWidget({super.key, required this.adStatus});

  final AdStatus adStatus;

  @override
  Widget build(BuildContext context) {
    return switch (adStatus) {
      AdStatus.top => Container(
          height: 20,
          width: 44,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFF0096B2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Assets.images.icFire.svg(height: 8, width: 8),
              'Top'.w(400).s(13).c(context.colors.textPrimaryInverse)
            ],
          ),
        ),
      AdStatus.standard => Center()
    };
  }
}
