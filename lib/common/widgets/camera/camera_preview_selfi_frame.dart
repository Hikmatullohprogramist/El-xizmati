import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewSelfieFrame extends StatefulWidget {
  const CameraPreviewSelfieFrame({super.key});

  @override
  _CameraPreviewSelfieFrameState createState() =>
      _CameraPreviewSelfieFrameState();
}

class _CameraPreviewSelfieFrameState extends State<CameraPreviewSelfieFrame> {
  CameraController? controller;
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.isNotEmpty) {
        controller = CameraController(cameras[1], ResolutionPreset.medium);
        controller?.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    }).catchError((e) {
      // Handle errors here
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CameraPreview(controller!),
        CustomPaint(
          size: Size.infinite,
          painter: FramePainter(),
        ),
        Positioned(
          bottom: 20,
          child: Text(
            'Смотрите на камеру до окончания процесса',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class FramePainter extends CustomPainter {
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
