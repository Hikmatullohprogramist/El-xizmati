import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
    this.color,
    this.type = ButtonType.elevated,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget text;
  final bool isEnabled;
  final Color? color;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    DateTime? clickTime;

    final onButtonPressed = !isEnabled ? null : () {
      if (isLoading) {
        return;
      }

      final difference =
          clickTime?.difference(DateTime.now()).inMilliseconds ?? -1000;

      if (difference > -1000) {
        return;
      }

      clickTime = DateTime.now();

      onPressed?.call();
    };

    switch (type) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            backgroundColor: color ?? context.colors.buttonPrimary,
            disabledBackgroundColor: (color ?? context.colors.buttonPrimary).withAlpha(150),
            elevation: 0,
          ),
          child: _buildChild(context),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onButtonPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: BorderSide(
              color: color ?? context.colors.primary,
            ),
          ),
          child: _buildChild(context),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onButtonPressed,
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: color ?? context.colors.buttonPrimary),
          ),
          child: _buildChild(context),
        );
    }
  }

  Widget _buildChild(BuildContext context) {
    return isLoading
        ? SizedBox(
      height: 23,
      width: 23,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 3,
        backgroundColor: type == ButtonType.elevated
            ? context.colors.buttonPrimary
            : context.colors.primary,
      ),
    )
        : text;
  }
}

enum ButtonType { elevated, outlined, text }
