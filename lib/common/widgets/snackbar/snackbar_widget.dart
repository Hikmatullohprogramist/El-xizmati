import 'package:flutter/material.dart';

extension CustomSnackBar on BuildContext {
  void showCustomSnackBar({
    required String message,
    Color backgroundColor = Colors.red,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Center(child: Column(
          children: [
            SizedBox(height: 5,),
            Text(message),
            SizedBox(height:5 ,)
          ],
        )),
        backgroundColor: backgroundColor,
        behavior: behavior,
        duration: duration,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}