import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';

extension CustomSnackBar on BuildContext {
  void showCustomSnackBar({
    required String message,
    Color backgroundColor = StaticColors.toastDefaultBackgroundColor,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Center(
            child: Column(
          children: [
            SizedBox(height: 6),
            Text(message),
            SizedBox(height: 6),
          ],
        )),
        backgroundColor: backgroundColor,
        behavior: behavior,
        duration: duration,
        shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    showCustomSnackBar(
      message: message,
      backgroundColor: StaticColors.toastSuccessBackgroundColor,
    );
  }

  void showErrorSnackBar(String message) {
    showCustomSnackBar(
      message: message,
      backgroundColor: StaticColors.toastErrorBackgroundColor,
    );
  }
}
