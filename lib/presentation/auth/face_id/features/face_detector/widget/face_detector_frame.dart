import 'package:flutter/material.dart';

class FaceDetectorFrame extends StatefulWidget {
  const FaceDetectorFrame({super.key});

  @override
  State<FaceDetectorFrame> createState() => _FaceDetectorFrameState();
}

class _FaceDetectorFrameState extends State<FaceDetectorFrame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 247,
      child: Stack(
        children: [
          _buildTransparentCircle(context),
        ],
      ),
    );
  }

  // Stream<bool> align() async* {
  //   bool value = false;
  //   while(true){
  //     yield value;
  //     await Future.delayed(Duration(seconds: 2));
  //     value = !value;
  //   }
  // }

  Widget _buildTransparentCircle(BuildContext context) {
    return Container(
      width: 225,
      height: 225,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent.withOpacity(0.3),
      ),
    );
  }
}
