import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/camera/camera_preview_rounded_widget.dart';

import 'face_id_confirmation_cubit.dart';

@RoutePage()
class FaceIdConfirmationPage extends BasePage<FaceIdConfirmationCubit,
    FaceIdConfirmationState, FaceIdConfirmationEvent> {
  final secretKey;

  const FaceIdConfirmationPage(this.secretKey, {super.key});

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setSecretKey(secretKey.toString());
  }

  @override
  void onEventEmitted(BuildContext context, FaceIdConfirmationEvent event) {
    switch (event.type) {
      case FaceIdConfirmationEventType.onStart:
        showProgressDialog(context);
      case FaceIdConfirmationEventType.onSuccess:
        {
          hideProgressBarDialog(context);
          context.router.replace(HomeRoute());
        }
      case FaceIdConfirmationEventType.onFailure:
        {
          hideProgressBarDialog(context);
          showErrorBottomSheet(context, Strings.faceIdIdentityNotVerified);
        }
      case FaceIdConfirmationEventType.onShowTakenPhoto:
        _showTakenPhotoBottomSheet(context, cubit(context).states);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, FaceIdConfirmationState state) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: DefaultAppBar(
        titleText: Strings.faceIdTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Container(
        child: _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, FaceIdConfirmationState state) {
    if (state.isCameraSetupLoadingVisible) {
      return _buildProgressIndicator();
    } else if (state.isIntroVisible) {
      return _buildIntroBlock(context);
    } else if (state.isCameraVisible) {
      return _buildCameraViews(context, state);
    } else {
      return _buildCameraViews(context, state);
    }
  }

  Widget _buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(StaticColors.buttonColor),
      ),
    );
  }

  Widget _buildIntroBlock(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 72),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Assets.images.faceInIntro.svg(width: 149, height: 149),
                      Assets.images.icRedError.svg(width: 32, height: 32),
                    ],
                  ),
                  SizedBox(height: 48),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Strings.faceIdIntroTitle
                        .s(16)
                        .w(600)
                        .c(context.textPrimary)
                        .copyWith(textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Strings.faceIdIntroFaceFrame
                            .w(400)
                            .s(15)
                            .copyWith(textAlign: TextAlign.start),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Strings.faceIdIntroFaceBlock
                            .w(400)
                            .s(15)
                            .copyWith(maxLines: 2, textAlign: TextAlign.start),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Strings.faceIdIntroFaceIllumination
                            .w(400)
                            .s(15)
                            .copyWith(maxLines: 2, textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.textSecondary,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Strings.faceIdIntroCameraPosition
                            .w(400)
                            .s(15)
                            .copyWith(maxLines: 2, textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                  SizedBox(height: 96),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: CustomElevatedButton(
              text: Strings.commonContinue,
              onPressed: () {
                cubit(context).closeIntroPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraViews(
    BuildContext context,
    FaceIdConfirmationState state,
  ) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Column(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              // alignment: Alignment.center,
              children: [
                _buildCameraPreView(context, state),
                _buildPreviewPainter(context, screenWidth, screenHeight),
              ],
            ),
          ),
        ),
        // SizedBox(height: 20),
        // _buildInstructionTexts(context),
        Spacer(),
        _buildActionButton(context, state),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCameraPreView(
    BuildContext context,
    FaceIdConfirmationState state,
  ) {
    final cameraController = state.cameraController;
    if (cameraController == null) return Center();

    final cameraAspectRatio = cameraController.value.aspectRatio;
    final screenAspectRatio = MediaQuery.of(context).size.aspectRatio;

    return ClipRect(
      clipper: _MediaSizeClipper(MediaQuery.of(context).size),
      child: Transform.scale(
        scale: 1 / (cameraAspectRatio * screenAspectRatio),
        alignment: Alignment.topCenter,
        child: CameraPreview(cameraController),
      ),
    );
  }

  Widget _buildPreviewPainter(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return CustomPaint(
      painter: CameraPreviewRoundedPainter(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        backgroundColor: context.backgroundWhiteColor,
      ),
    );
  }

  Widget _buildInstructionTexts(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Expanded(child: SizedBox()),
        Center(
          child:
              Strings.faceIdIndentityInfo.s(16).w(600).c(context.textPrimary),
        ),
        SizedBox(height: 16),
        Center(
            child: Strings.faceIdIndentityDesc
                .w(400)
                .s(14)
                .c(context.textSecondary)),
        // Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    FaceIdConfirmationState state,
  ) {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomElevatedButton(
          text: Strings.commonTakePhoto,
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
          leftIcon: Assets.images.icAddImageCamera
              .svg(width: 32, height: 32, color: Colors.white),
        ),
      ),
    );
  }

  void _showTakenPhotoBottomSheet(
    BuildContext context,
    FaceIdConfirmationState state,
  ) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext bc) {
        return Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              BottomSheetTitle(
                title: Strings.faceIdPreview,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Strings.faceIdCheckImageBeforeSending
                    .s(16)
                    .w(500)
                    .copyWith(textAlign: TextAlign.center),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.memory(
                  base64Decode(state.cropperImage),
                  fit: BoxFit.cover,
                  height: 400,
                  width: 300,
                ),
              ),
              SizedBox(height: 24),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomElevatedButton(
                  text: Strings.commonRetakePhoto,
                  onPressed: () {
                    Navigator.of(context).pop();
                    HapticFeedback.lightImpact();
                  },
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomElevatedButton(
                  text: Strings.commonSend,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                    cubit(context).sendImage(state.cropperImage);
                  },
                  isLoading: state.loading,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<String> cropImage(Uint8List takenPhoto) async {
    List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      takenPhoto,
      quality: 80,
      minHeight: 400,
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

class _CustomPathClipper extends CustomClipper<Path> {
  final Path path;

  _CustomPathClipper(this.path);

  @override
  Path getClip(Size size) => path;

  @override
  bool shouldReclip(_CustomPathClipper oldClipper) => oldClipper.path != path;
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
