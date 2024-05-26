import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';

class SeeAllWidget extends StatelessWidget {
  final String title;
  final VoidCallback onClicked;

  const SeeAllWidget({
    super.key,
    required this.title,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title.w(600).s(16).c(context.textPrimary),
          TextButton(
            onPressed: () {
              onClicked();
              vibrateAsHapticFeedback();
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
