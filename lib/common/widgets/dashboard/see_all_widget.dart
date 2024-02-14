import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/localization/strings.dart';
import '../../vibrator/vibrator_extension.dart';

class SeeAllWidget extends StatelessWidget {
  final String title;
  final VoidCallback onClicked;

  const SeeAllWidget({super.key, required this.onClicked, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title.w(600).s(16).c(context.colors.textPrimary),
          TextButton(
            onPressed: () {
              onClicked();
              vibrateByTactile();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Strings.allTitle.w(600).s(12).c(context.colors.textAccent),
                SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_right_rounded), // The arrow icon
              ],
            ),
          )
        ],
      ),
    );
  }
}
