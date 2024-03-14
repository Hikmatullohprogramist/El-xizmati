import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:image/image.dart' as img;

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/botton_sheet_for_result.dart';
import 'package:onlinebozor/presentation/auth/face_id/features/face_detector/widget/face_detector_frame.dart';

import '../../../../../common/colors/static_colors.dart';
import '../../../../../common/core/base_page.dart';
import 'package:onlinebozor/presentation/auth/face_id/features/face_detector/cubit/page_cubit.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/router/app_router.dart';
import '../../../../../common/widgets/button/custom_elevated_button.dart';

@RoutePage()
class FaceDetectorPage extends BasePage<PageCubit, PageState, PageEvent> {
  const FaceDetectorPage(
    this.secretKey, {
    super.key,
  });

  final secretKey;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setSecretKey(secretKey.toString());
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.navigationHome:
        context.router.replace(HomeRoute());
      case PageEventType.error:
      context.showErrorBottomSheet(context, Strings.loadingStateError,
          "Sizning shaxsingiz tasdiqlanmadi!");
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Stack(
      children: [
        if (cubit(context).states.loadState == LoadingState.loading)
          Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[300], // Set the background color
                valueColor: AlwaysStoppedAnimation<Color>(StaticColors.slateBlue), // Set the progress color
              )),
        if (cubit(context).states.loadState == LoadingState.success)
          ClipRect(
            clipper: _MediaSizeClipper(MediaQuery.of(context).size),
            child: Transform.scale(
                scale: 1 /
                    (cubit(context).states.cameraController!.value.aspectRatio *
                        MediaQuery.of(context).size.aspectRatio),
                alignment: Alignment.topCenter,
                child: CameraPreview(cubit(context).states.cameraController!)),
          ),
        Center(child: FaceDetectorFrame()),
        Positioned(
          bottom: 60,
          left: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                CustomElevatedButton(
                  text: "Tekshirish",
                  onPressed: () {
                    cubit(context)
                        .states
                        .cameraController
                        ?.takePicture()
                        .then((value) async {
                      final takeImage = File(value.path);
                      Uint8List imageBytes = await takeImage.readAsBytes();
                      String croppedImage = await croppImage(imageBytes);
                      cubit(context).sendImage(croppedImage, cubit(context).states.secretKey);
                    });
                  },
                  backgroundColor: context.colors.buttonPrimary,
                  isEnabled: true,
                  isLoading: cubit(context).states.loading,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 50, // Set the desired width
                  height: 50, // Set the desired height
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 30,
                    color: Colors.white, // Set the desired icon size
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<String> croppImage(Uint8List image2) async {
    List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      image2,
      quality: 80, //
      minHeight: 400, //
      minWidth: 300, //
    );
    String compressedBase64 = base64.encode(compressedBytes);
    final Uint8List imageBytesLast = base64Decode(compressedBase64);
    final img.Image? image = img.decodeImage(imageBytesLast);
    final img.Image croppedImage = img.copyResize(image!, width: 300, height: 400);
    String base64StringSecond = base64Encode(Uint8List.fromList(img.encodeJpg(croppedImage, quality: 80)));
    log(base64StringSecond);
    return base64StringSecond;
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;

  const _MediaSizeClipper(this.mediaSize);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
