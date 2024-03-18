import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image/image.dart' as img;
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/botton_sheet_for_result.dart';
import 'package:onlinebozor/common/widgets/camera/camera_selfi_painter.dart';

import '../../../../../common/colors/static_colors.dart';
import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/router/app_router.dart';
import '../../../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../../../common/widgets/button/custom_elevated_button.dart';
import 'cubit/page_cubit.dart';

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
        context.showErrorBottomSheet(context, Strings.loadingStateError,
            Strings.faceIdIdentityNotVerified);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Stack(
      children: [
        _buildConditionalWidget(
          state.loadState == LoadingState.loading,
          progressIndicator(),
        ),
        if (state.loadState == LoadingState.success && (!state.introState))
          _buildCameraPreView(context),
        CustomPaint(
          size: Size.infinite,
          painter: CameraSelfiePainter(),
        ),
        _buildFaceDetectorConstruction(context),
        checkActionButton(context, state),
        _buildConditionalWidget(
            state.introState, _buildFaceDetectorIntroPage(context))
      ],
    );
  }

  Widget _buildConditionalWidget(bool condition, Widget widget) =>
      condition ? widget : SizedBox.shrink();

  Widget _buildFaceDetectorIntroPage(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar("Face-ID", () => context.router.pop()),
      body: Padding(
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
            Text("Перед тем как сделать снимок,  убедитесь в том, что:",
                    maxLines: 2, textAlign: TextAlign.center)
                .w(600)
                .s(17)
                .c(context.colors.textPrimary),
            SizedBox(height: 40),
            Row(
              children: [
                Container(
                  width: 5, // Diameter of the spot (2 * radius)
                  height: 5, // Diameter of the spot (2 * radius)
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF9EABBE)),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: Text(
                    "Лицо полностью вписывается в указанную рамку:",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ).w(400).s(15).c(Color(0xFF9EABBE)),
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
                    color: Color(0xFF9EABBE),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 300,
                  child: Text(
                    "Лицо не перекрыто посторонними объектами (Очки, головной убор и т.д)",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ).w(400).s(15).c(Color(0xFF9EABBE)),
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
                    color: Color(0xFF9EABBE),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 250,
                  child: Text(
                    "Лицо освещено равномерно",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ).w(400).s(15).c(Color(0xFF9EABBE)),
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
                    color: Color(0xFF9EABBE),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 250,
                  child: Text(
                    "Камера расположена строго перед лицом)",
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ).w(400).s(15).c(Color(0xFF9EABBE)),
                )
              ],
            ),
            Expanded(child: SizedBox(width: 1)),
            CustomElevatedButton(
              text: "Продолжить",
              onPressed: () {
                cubit(context).closeIntroPage();
              },
              backgroundColor: context.colors.buttonPrimary,
            ),
            SizedBox(height: 25)
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
          SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Face ID".w(600).s(22).c(context.colors.textPrimary),
            ],
          ),
          Expanded(child: SizedBox()),
          SizedBox(
            width: 253,
            child: Text(
              "Смотрите на камеру и нажмите снять фото",
              textAlign: TextAlign.center,
            ).w(600).s(16).c(context.colors.textPrimary),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 253,
            child: Text(
              "Все части лица должны вписаться в область камеры",
              textAlign: TextAlign.center,
            ).w(400).s(12).c(Color(0xFF9EABBE)),
          ),
          SizedBox(height: 160)
        ],
      ),
    );
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

  Widget checkActionButton(BuildContext context, PageState state) {
    return Positioned(
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
                cubit(context).states.cameraController?.takePicture().then(
                  (value) async {
                    final takeImage = File(value.path);
                    Uint8List imageBytes = await takeImage.readAsBytes();
                    String croppedImage = await cropImage(imageBytes);

                    cubit(context).sendImage(
                      croppedImage,
                      cubit(context).states.secretKey,
                    );
                  },
                );
              },
              backgroundColor: context.colors.buttonPrimary,
              isEnabled: true,
              isLoading: state.loading,
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
    );
  }

  Widget progressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(StaticColors.slateBlue),
      ),
    );
  }

  Future<String> cropImage(Uint8List image2) async {
    List<int> compressedBytes = await FlutterImageCompress.compressWithList(
      image2,
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
      Uint8List.fromList(img.encodeJpg(croppedImage, quality: 80)),
    );
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
