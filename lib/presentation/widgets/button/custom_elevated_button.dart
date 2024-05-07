import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 48,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor = Colors.white,
    this.textSize = 14,
    this.backgroundColor,
    this.rightIcon,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;
  final bool isEnabled;
  final Color textColor;
  final double textSize;
  final Color? backgroundColor;
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
              onPressed?.call();
            }
          }
        : null;

    var actualTextColor = isEnabled ? textColor : textColor.withOpacity(0.75);
    var backcolor = backgroundColor ?? context.colors.buttonPrimary;
    var actualBackgroundColor =
        isEnabled ? backcolor : backcolor.withOpacity(0.75);
    var actualTextAlign = rightIcon != null ? TextAlign.left : TextAlign.center;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          backgroundColor: actualBackgroundColor,
          disabledBackgroundColor: actualBackgroundColor.withAlpha(150),
          elevation: 0,
        ),
        child: SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: Row(
            children: [
              Expanded(
                child: text.w(400).s(textSize).c(actualTextColor).copyWith(
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
                    color: Colors.white,
                    strokeWidth: 1.5,
                    strokeAlign: 0.5,
                  ),
                ),
              ),
              Visibility(
                visible: rightIcon != null,
                child: SizedBox(width: 12),
              ),
              Visibility(
                visible: rightIcon != null,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: rightIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
