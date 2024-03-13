import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
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
          Image.asset("assets/images/png_images/frame_face.png", fit: BoxFit.fill,width: 247,height: 400,),
        // StreamBuilder<bool>(
        //     stream: align(),
        //     builder: (context, snapshot) {
        //       return AnimatedAlign(alignment: snapshot.data ?? false ? Alignment.topCenter : Alignment.bottomCenter, duration: Duration(seconds: 2), child: Image.asset("assets/images/png_images/img.png"),);
        //     }
        // ),

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

}
