import 'package:flutter/material.dart';

class CameraSelfiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.86); // Semi-transparent black
    // Draw the background
    canvas.drawRect(Offset.zero & size, paint);

    // Define the frame size
    final frameSize = Size(size.width * 0.65, size.height * 0.4);
    final frameRect = Offset((size.width - frameSize.width) / 2,
            (size.height - frameSize.height) / 2) &
        frameSize;

    // Clear the frame area
    paint.blendMode = BlendMode.clear;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          frameRect,
          topLeft: Radius.circular(120),
          topRight: Radius.circular(120),
          bottomRight: Radius.circular(120),
          bottomLeft: Radius.circular(120),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
