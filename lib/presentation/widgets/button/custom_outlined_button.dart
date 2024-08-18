import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;
  final bool isEnabled;
  final bool isSelected;
  final Color? textColor;
  final Color strokeColor;
  final Widget? rightIcon;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 48,
    this.isEnabled = true,
    this.isLoading = false,
    this.isSelected = false,
    this.textColor,
    this.strokeColor = StaticColors.buttonColor,
    this.rightIcon,
  }) : super(key: key);



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

    final textColor1 = textColor ?? context.textPrimary;
    var actualTextColor = isEnabled ? textColor1 : textColor1.withOpacity(0.75);
    var actualStrokeColor = isEnabled
        ? strokeColor.withOpacity(0.75)
        : strokeColor.withOpacity(0.55);
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
          width: 2,
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
              child: SizedBox(width: 24, height: 24, child: rightIcon),
            ),
          ],
        ),
      ),
    );
  }
}
