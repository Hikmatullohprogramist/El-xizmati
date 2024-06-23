import 'package:flutter/material.dart';

class CameraPreviewCirclePainter extends CustomPainter {
  final double screenWidth;
  final double screenHeight;

  CameraPreviewCirclePainter({
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = screenWidth * 0.40;
    const strokeWidth = 2.0;
    final circlePath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(screenWidth / 2, screenHeight / 2.5),
          radius: radius,
        ),
      );

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
