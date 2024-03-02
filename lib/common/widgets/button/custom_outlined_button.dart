import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final bool isEnabled;
  final Color? textColor;

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

    var defaultTextColor = Color(0xFF5C6AC3).withOpacity(isEnabled ? 1 : 0.75);

    return OutlinedButton(
      onPressed: onButtonPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: BorderSide(
          color: textColor ?? context.colors.primary,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text.w(400).s(14).c(context.colors.textPrimary),
          Visibility(visible: isLoading, child: SizedBox(width: 12)),
          Visibility(
            visible: isLoading,
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: textColor ?? defaultTextColor,
                strokeWidth: 1.5,
                strokeAlign: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ButtonType { elevated, outlined, text }
