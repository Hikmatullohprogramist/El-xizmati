/*
import 'package:flutter/material.dart';

class CameraSelfiePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white.withOpacity(0.3);
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

*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayPainter extends CustomPainter {
  final double screenWidth;
  final double screenHeight;

  OverlayPainter({required this.screenWidth, required this.screenHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = screenWidth * 0.40;
    const strokeWidth = 2.0;
    final circlePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(screenWidth / 2, screenHeight / 2.5),
        radius: radius,
      ));

    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight));
    final overlayPath =
        Path.combine(PathOperation.difference, outerPath, circlePath);

    final paint = Paint()
      ..color = Colors.white.withOpacity(1)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(overlayPath, paint);
    canvas.drawCircle(
      Offset(screenWidth / 2, screenHeight / 2.5),
      radius,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
