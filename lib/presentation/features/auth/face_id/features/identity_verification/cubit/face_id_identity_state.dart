part of 'face_id_identity_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(LoadingState.loading) LoadingState loadState,
    @Default(false) bool loading,
    @Default(true) bool introState,
    @Default(false) bool showPicture,
    @Default(<CameraDescription>[]) List<CameraDescription> cameras,
    CameraController? cameraController,
    @Default("") String secretKey,
    @Default("") String cropperImage,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { onSuccess, onFailure }
