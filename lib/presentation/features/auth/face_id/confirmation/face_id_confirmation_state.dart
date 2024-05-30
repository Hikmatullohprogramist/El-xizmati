part of 'face_id_confirmation_cubit.dart';

@freezed
class FaceIdConfirmationState with _$FaceIdConfirmationState {
  const factory FaceIdConfirmationState({
    @Default(LoadingState.loading) LoadingState loadState,
    @Default(false) bool loading,
    @Default(true) bool introState,
    @Default(false) bool showPicture,
    @Default(<CameraDescription>[]) List<CameraDescription> cameras,
    CameraController? cameraController,
    @Default("") String secretKey,
    @Default("") String cropperImage,
  }) = _FaceIdConfirmationState;
}

@freezed
class FaceIdConfirmationEvent with _$FaceIdConfirmationEvent {
  const factory FaceIdConfirmationEvent(FaceIdConfirmationEventType type) =
      _FaceIdConfirmationEvent;
}

enum FaceIdConfirmationEventType { onSuccess, onFailure }
