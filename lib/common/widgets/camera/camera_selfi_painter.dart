import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_launcher_icons/xml_templates.dart';



class CameraSelfiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(1); // Semi-transparent black
    // Draw the background
      canvas.drawRect(Offset.zero & size, paint);

    // Define the frame size
    final frameSize = Size(size.width * 0.65, size.height * 0.4);
    final frameRect = Offset((size.width - frameSize.width) / 2, (size.height - frameSize.height) / 2.6) & frameSize;

    // Clear the frame area
    paint.blendMode = BlendMode.clear;

   canvas.drawRRect(
       RRect.fromRectAndCorners(
         frameRect,
         topLeft: Radius.circular(140),
         topRight: Radius.circular(140),
         bottomRight: Radius.circular(150),
         bottomLeft: Radius.circular(150),
       ),
       paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

