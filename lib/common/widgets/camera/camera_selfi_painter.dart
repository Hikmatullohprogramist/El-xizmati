import 'package:flutter/material.dart';

class CameraSelfiePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white.withOpacity(1);
    // Draw the background
    canvas.drawRect(Offset.zero & size, paint);

    // Define the frame size
    final frameSize = Size(size.width * 0.65, size.height * 0.4);
    final offset = Offset(
      (size.width - frameSize.width) / 2,
      (size.height - frameSize.height) / 2.4,
    );
    final frameRect = offset & frameSize;

    // Clear the frame area
    paint.blendMode = BlendMode.clear;

    var rRect = RRect.fromRectAndCorners(
      frameRect,
      topLeft: Radius.circular(140),
      topRight: Radius.circular(140),
      bottomRight: Radius.circular(150),
      bottomLeft: Radius.circular(150),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
