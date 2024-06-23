import 'package:flutter/material.dart';

class CameraPreviewRoundedPainter extends CustomPainter {
  final double screenWidth;
  final double screenHeight;

  CameraPreviewRoundedPainter({
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double rectWidth = screenWidth * 0.75;
    final double rectHeight = screenHeight * 0.45;
    const double cornerRadius = 24;
    const double strokeWidth = 2;

    final rectPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: Offset(screenWidth / 2, screenHeight / 2.5),
          width: rectWidth,
          height: rectHeight,
        ),
        topLeft: Radius.circular(cornerRadius),
        topRight: Radius.circular(cornerRadius),
        bottomLeft: Radius.circular(cornerRadius),
        bottomRight: Radius.circular(cornerRadius),
      ));

    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight));

    final overlayPath =
        Path.combine(PathOperation.difference, outerPath, rectPath);

    final paint = Paint()
      ..color = Colors.white.withOpacity(1)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(overlayPath, paint);
    canvas.drawPath(rectPath, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
