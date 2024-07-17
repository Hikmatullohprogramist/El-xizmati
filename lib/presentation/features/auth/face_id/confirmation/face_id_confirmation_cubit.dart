import 'dart:async';

import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/domain/models/faceid/face_id_confirm_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'face_id_confirmation_cubit.freezed.dart';
part 'face_id_confirmation_state.dart';

@injectable
class FaceIdConfirmationCubit
    extends BaseCubit<FaceIdConfirmationState, FaceIdConfirmationEvent> {
  final AuthRepository _authRepository;

  FaceIdConfirmationCubit(
    this._authRepository,
  ) : super(const FaceIdConfirmationState());

  @override
  Future<void> close() async {
    await closeCamera();

    super.close();
  }

  void setInitialParams(String secretKey, FaceIdConfirmType faceIdConfirmType) {
    updateState((state) => state.copyWith(
          faceIdConfirmType: faceIdConfirmType,
          secretKey: secretKey,
        ));

    setupCamera();
  }

  void setupCamera() async {
    await initCamera().then((value) {
      updateState((state) => state.copyWith(
            cameraInitState: LoadingState.success,
          ));
    });
  }

  Future<void> initCamera() async {
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

  Future<void> closeCamera() async {
    await states.cameraController?.dispose();
  }

  void sendImage(String image) async {
    (states.faceIdConfirmType == FaceIdConfirmType.forSingIn
            ? _authRepository.signInFaceIdIdentity(image, states.secretKey)
            : _authRepository.registerFaceIdIdentity(image, states.secretKey))
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(loading: true));
          emitEvent(FaceIdConfirmationEvent(
            FaceIdConfirmationEventType.onRequestStarted,
          ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                loading: false,
              ));
          emitEvent(FaceIdConfirmationEvent(
            FaceIdConfirmationEventType.onRequestFinished,
          ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(loading: false));
          emitEvent(FaceIdConfirmationEvent(
            FaceIdConfirmationEventType.onRequestFailed,
          ));
          stateMessageManager
              .showErrorBottomSheet(Strings.faceIdIdentityNotVerified);
        })
        .onFinished(() {})
        .executeFuture();
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
