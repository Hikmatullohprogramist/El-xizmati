import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.onPressed,
    this.loading = false,
    required this.child,
    this.enabled = true,
    this.color,
    this.type = ButtonType.elevated,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool loading;
  final Widget child;
  final bool enabled;
  final Color? color;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    DateTime? clickTime;

    final onButtonPressed = !enabled
        ? null
        : () {
            if (loading) {
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
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: _buildChild(context),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onButtonPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
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
    return loading
        ? SizedBox(
            height: 23,
            width: 23,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 3,
              backgroundColor: type == ButtonType.elevated
                  ? context.colors.onPrimary
                  : context.colors.primary,
            ),
          )
        : child;
  }
}

enum ButtonType { elevated, outlined, text }
