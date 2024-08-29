import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;
  final bool isEnabled;
  final Color textColor;
  final double textSize;
  final Color? backgroundColor;
  final Widget? leftIcon;
  final Widget? rightIcon;

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
    this.leftIcon,
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
              onPressed?.call();
            }
          }
        : null;

    var actualTextColor = isEnabled ? textColor : textColor.withOpacity(0.75);
    var backcolor = backgroundColor ?? context.colors.buttonPrimary;
    var actualBackgroundColor = isEnabled ? backcolor : backcolor.withOpacity(0.75);
    var actualTextAlign = TextAlign.center;

    final hasIcon = leftIcon != null || rightIcon != null;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        autofocus: true,
        clipBehavior: Clip.hardEdge,
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: actualBackgroundColor,
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: actualBackgroundColor.withAlpha(150),
          elevation: 3,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [actualBackgroundColor, Color(0xFF9A6AFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
          ),
          width: buttonWidth,
          height: buttonHeight,
          child: Row(
            children: [
              Visibility(
                visible: hasIcon,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: leftIcon,
                ),
              ),
              Visibility(
                visible: hasIcon,
                child: SizedBox(width: 12),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    text.w(400).s(textSize).c(actualTextColor).copyWith(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: actualTextAlign,
                        ).w(500),
                    SizedBox(width: 4),
                    Visibility(
                      visible: hasIcon,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: rightIcon,
                      ),
                    ),
                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
