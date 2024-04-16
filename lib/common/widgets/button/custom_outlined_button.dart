import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../colors/static_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 48,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor = StaticColors.textColorPrimary,
    this.strokeColor = StaticColors.buttonDefaultBackgroundColor,
    this.rightIcon,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;
  final bool isEnabled;
  final Color textColor;
  final Color strokeColor;
  final Widget? rightIcon;

  bool isClickedRecently(DateTime? lastClickTime) {
    if (lastClickTime == null) return false;
    var now = DateTime.now();
    return (lastClickTime.difference(now).inMilliseconds) > -1000;
  }

  @override
  Widget build(BuildContext context) {
    DateTime? clickTime;

    final onButtonPressed = isEnabled
        ? () {
            if (isLoading) {
              return;
            } else if (isClickedRecently(clickTime)) {
              return;
            } else {
              clickTime = DateTime.now();
              onPressed.call();
            }
          }
        : null;

    var actualTextColor = isEnabled ? textColor : textColor.withOpacity(0.75);
    var actualStrokeColor =
        isEnabled ? strokeColor : strokeColor.withOpacity(0.75);
    var actualTextAlign = rightIcon != null ? TextAlign.left : TextAlign.center;

    return OutlinedButton(
      onPressed: onButtonPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: actualStrokeColor.withOpacity(0.015),
        foregroundColor: actualStrokeColor.withOpacity(0.45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          width: 1,
          color: actualStrokeColor,
        ),
      ),
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: Row(
          children: [
            Expanded(
              child: text.w(400).s(13).c(actualTextColor).copyWith(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: actualTextAlign,
                  ),
            ),
            Visibility(visible: isLoading, child: SizedBox(width: 12)),
            Visibility(
              visible: isLoading,
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: actualStrokeColor,
                  strokeWidth: 1.5,
                  strokeAlign: 0.5,
                ),
              ),
            ),
            Visibility(visible: rightIcon != null, child: SizedBox(width: 12)),
            Visibility(
              visible: rightIcon != null,
              child: SizedBox(width: 20, height: 20, child: rightIcon),
            ),
          ],
        ),
      ),
    );
  }
}
