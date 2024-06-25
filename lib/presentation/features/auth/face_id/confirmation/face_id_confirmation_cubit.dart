import 'dart:async';

import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'face_id_confirmation_cubit.freezed.dart';
part 'face_id_confirmation_state.dart';

@injectable
class FaceIdConfirmationCubit
    extends BaseCubit<FaceIdConfirmationState, FaceIdConfirmationEvent> {
  final AuthRepository _authRepository;
  final FavoriteRepository _favoriteRepository;

  FaceIdConfirmationCubit(
    this._authRepository,
    this._favoriteRepository,
  ) : super(const FaceIdConfirmationState()) {
    setupCamera();
  }

  void setupCamera() async {
    await initialCamera().then((value) {
      updateState((state) => state.copyWith(
            cameraInitState: LoadingState.success,
          ));
    });
  }

  Future<void> initialCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    final CameraController cameraController = CameraController(
      cameras[1],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController.initialize();
    updateState((state) => state.copyWith(
          cameras: cameras,
          cameraController: cameraController,
          cameraInitState: LoadingState.loading,
        ));
  }

  void setSecretKey(String secretKey) {
    updateState((state) => state.copyWith(secretKey: secretKey));
  }

  void sendImage(String image) async {
    _authRepository
        .sendImage(image, states.secretKey)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(loading: true));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                loading: false,
              ));
          sendAllFavoriteAds();
          emitEvent(
              FaceIdConfirmationEvent(FaceIdConfirmationEventType.onSuccess));
        })
        .onError((error) {
          updateState((state) => state.copyWith(loading: false));
          emitEvent(
              FaceIdConfirmationEvent(FaceIdConfirmationEventType.onFailure));
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      stateMessageManager.showErrorSnackBar("Xatolik yuz berdi");
      emitEvent(FaceIdConfirmationEvent(FaceIdConfirmationEventType.onSuccess));
    }
  }

  void closeIntroPage() {
    updateState((state) => state.copyWith(isIntroVisible: false));
  }

  void showPicture(bool isVisible) {
    emitEvent(
        FaceIdConfirmationEvent(FaceIdConfirmationEventType.onShowTakenPhoto));
  }

  void croppedImage(String value) {
    updateState((state) => state.copyWith(cropperImage: value));
  }
}
