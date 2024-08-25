import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';

import '../../../domain/models/ad/ad_priority_level.dart';

class AppAdStatusWidget extends StatelessWidget {
  const AppAdStatusWidget({super.key, required this.adStatus});

  final AdPriorityLevel adStatus;

  @override
  Widget build(BuildContext context) {
    return switch (adStatus) {
      AdPriorityLevel.top => Container(
          height: 20,
          width: 44,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFF0096B2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Assets.images.icFire.svg(height: 10, width: 10),
              'Top'.w(400).s(13).c(context.textPrimaryInverse)
            ],
          ),
        ),
      AdPriorityLevel.standard => Center()
    };
  }
}
