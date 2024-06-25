part of 'face_id_confirmation_cubit.dart';

@freezed
class FaceIdConfirmationState with _$FaceIdConfirmationState {
  const FaceIdConfirmationState._();

  const factory FaceIdConfirmationState({
    @Default(true) bool isIntroVisible,
//
    @Default(<CameraDescription>[]) List<CameraDescription> cameras,
    CameraController? cameraController,
//
    @Default(LoadingState.loading) LoadingState cameraInitState,
    @Default(false) bool loading,
//
    @Default("") String secretKey,
//
    @Default("") String cropperImage,
  }) = _FaceIdConfirmationState;

  bool get isCameraSetupLoadingVisible =>
      cameraInitState == LoadingState.loading;

  bool get isCameraVisible =>
      cameraInitState == LoadingState.success && !isIntroVisible;
}

@freezed
class FaceIdConfirmationEvent with _$FaceIdConfirmationEvent {
  const factory FaceIdConfirmationEvent(FaceIdConfirmationEventType type) =
      _FaceIdConfirmationEvent;
}

enum FaceIdConfirmationEventType {
  onStart,
  onSuccess,
  onFailure,
  onShowTakenPhoto
}
