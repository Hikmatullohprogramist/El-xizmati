import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image/image.dart' as img;
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/presentation/widgets/camera/camera_selfi_painter.dart';

import 'cubit/face_id_identity_cubit.dart';

@RoutePage()
class FaceIdIdentityPage extends BasePage<PageCubit, PageState, PageEvent> {
  const FaceIdIdentityPage(
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
      case PageEventType.onSuccess:
        context.router.replace(HomeRoute());
      case PageEventType.onFailure:
        showErrorBottomSheet(context, Strings.faceIdIdentityNotVerified);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Stack(
      children: [
        _buildConditionalWidget(
          state.loadState == LoadingState.loading,
          progressIndicator(),
        ),
        if (state.loadState == LoadingState.success && (!state.introState))
          _buildCameraPreView(context),
        CustomPaint(
          painter: OverlayPainter(
              screenWidth: screenWidth, screenHeight: screenHeight),
        ),
        _buildFaceDetectorConstruction(context),
        _buildActionButton(context, state),
        _buildConditionalWidget(
          state.introState,
          _buildFaceDetectorIntroPage(context),
        ),
        if (state.showPicture) _buildShowPicture(context, state)
      ],
    );
  }

  Widget _buildConditionalWidget(bool condition, Widget widget) =>
      condition ? widget : SizedBox.shrink();

  Widget _buildFaceDetectorIntroPage(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: Strings.profileIdentify,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SvgPicture.asset('assets/images/face_in_intro.svg',
                          height: 149, width: 149),
                      SvgPicture.asset('assets/images/ic_red_error.svg',
                          height: 32, width: 32),
                    ],
                  ),
                  SizedBox(height: 35),
                  Text(Strings.faceIdIntroTitle,
                          maxLines: 2, textAlign: TextAlign.center)
                      .w(600)
                      .s(17)
                      .c(context.textPrimary),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Container(
                        width: 5, // Diameter of the spot (2 * radius)
                        height: 5, // Diameter of the spot (2 * radius)
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 300,
                        child: Text(
                          Strings.faceIdIntroFaceFrame,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ).w(400).s(15).c(Colors.black87),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 5, // Diameter of the spot (2 * radius)
                        height: 5, // Diameter of the spot (2 * radius)
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 300,
                        child: Text(
                          Strings.faceIdIntroFaceBlock,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ).w(400).s(15).c(Colors.black87),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 5, // Diameter of the spot (2 * radius)
                        height: 5, // Diameter of the spot (2 * radius)
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 250,
                        child: Text(
                          Strings.faceIdIntroFaceIllumination,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ).w(400).s(15).c(Colors.black87),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 5, // Diameter of the spot (2 * radius)
                        height: 5, // Diameter of the spot (2 * radius)
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 250,
                        child: Text(
                          Strings.faceIdIntroCameraPosition,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ).w(400).s(15).c(Colors.black87),
                      )
                    ],
                  ),
                  Expanded(child: SizedBox(width: 1)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomElevatedButton(
                  text: Strings.commonContinue,
                  onPressed: () {
                    cubit(context).closeIntroPage();
                  },
                  backgroundColor: context.colors.buttonPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceDetectorConstruction(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    context.navigateBack();
                  },
                  icon: Assets.images.icArrowLeft.svg(),
                ),
                Expanded(child: SizedBox()),
                Strings.profileIdentify
                    .w(600)
                    .s(18)
                    .c(context.textPrimary),
                Expanded(child: SizedBox()),
                SizedBox(width: 25)
              ],
            ),
            Expanded(child: SizedBox()),
            SizedBox(
                width: 253,
                child: Text(
                  Strings.faceIdIndentityInfo,
                  textAlign: TextAlign.center,
                ).w(600).s(16).c(context.textPrimary)),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 253,
              child: Text(
                Strings.faceIdIndentityDesc,
                textAlign: TextAlign.center,
              ).w(400).s(12).c(context.textSecondary),
            ),
            SizedBox(
              height: 160,
            )
          ],
        ));
  }

  Widget _buildCameraPreView(BuildContext context) {
    return ClipRect(
      clipper: _MediaSizeClipper(MediaQuery.of(context).size),
      child: Transform.scale(
        scale: 1 /
            (cubit(context).states.cameraController!.value.aspectRatio *
                MediaQuery.of(context).size.aspectRatio),
        alignment: Alignment.topCenter,
        child: CameraPreview(cubit(context).states.cameraController!),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, PageState state) {
    return Positioned(
      bottom: 10,
      left: 10,
      right: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomElevatedButton(
              text: Strings.faceIdCheck,
              onPressed: () {
                cubit(context).states.cameraController?.takePicture().then(
                  (value) async {
                    final takeImage = File(value.path);
                    Uint8List imageBytes = await takeImage.readAsBytes();
                    String croppedImage = await cropImage(imageBytes);
                    cubit(context).croppedImage(croppedImage);
                    cubit(context).showPicture(true);
                  },
                );
              },
              backgroundColor: context.colors.buttonPrimary,
              isEnabled: true,
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              width: 32, // Set the desired width
              height: 32, // Set the desired height
              child: SvgPicture.asset(
                'assets/images/ic_add_image_camera.svg',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowPicture(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: 500,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                SizedBox(height: 20),
                Strings.authFaceIdImageQuality.w(500).s(16).c(Colors.black),
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.memory(
                        base64Decode(state.cropperImage),
                        fit: BoxFit.cover,
                        height: 330,
                        width: 250,
                      ),
                    ),
                    Visibility(
                      visible: state.loading,
                      child: CircularProgressIndicator(
                        color: StaticColors.colorPrimary,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomOutlinedButton(
                          text: Strings.commonRetry,
                          strokeColor: Colors.red,
                          onPressed: () {
                            cubit(context).showPicture(false);
                            vibrateAsHapticFeedback();
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomOutlinedButton(
                          text: Strings.commonContinue,
                          strokeColor: Colors.green,
                          onPressed: () {
                            vibrateAsHapticFeedback();
                            cubit(context).sendImage(state.cropperImage,
                                cubit(context).states.secretKey);
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget progressIndicator() {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(StaticColors.buttonColor),
    ));
  }

  void showAlertDialog(BuildContext context, String image) {
    final decodedBytes = base64Decode(image);
    final photo = img.decodeImage(decodedBytes);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return dialog content
        return AlertDialog(
          title: Text(
                  '${photo?.width}x${photo?.height}  size=>${(image.length * 1.5 / 1024 / 2).floor()} kb')
              .s(16),
          content: Image.memory(
            base64Decode(image),
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Bekor qilish'),
            ),
          ],
        );
      },
    );
  }

  void fullscree(BuildContext context, String image) {
    var parentContext = context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                SizedBox(height: 20),
                "Rasm sifatiga ishonch hosil qiling"
                    .w(500)
                    .s(16)
                    .c(Colors.black),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.memory(
                    base64Decode(image),
                    fit: BoxFit.cover,
                    height: 330,
                    width: 250,
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomOutlinedButton(
                          text: "Qayta tushish",
                          strokeColor: Colors.red,
                          onPressed: () {
                            Navigator.pop(context);
                            vibrateAsHapticFeedback();
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomOutlinedButton(
                          text: "Davom etish",
                          strokeColor: Colors.green,
                          onPressed: () {
                            vibrateAsHapticFeedback();

                            cubit(parentContext).sendImage(
                                image, cubit(context).states.secretKey);
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> cropImage(Uint8List image2) async {
    List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      image2,
      quality: 80,
      minHeight: 553,
      minWidth: 300,
    );
    String compressedBase64 = base64.encode(compressedBytes);
    final Uint8List imageBytesLast = base64Decode(compressedBase64);
    final img.Image? image = img.decodeImage(imageBytesLast);
    final img.Image croppedImage =
        img.copyResize(image!, width: 300, height: 400);
    String base64StringSecond = base64Encode(
        Uint8List.fromList(img.encodeJpg(croppedImage, quality: 80)));
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
