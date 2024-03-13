
part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(LoadingState.loading) LoadingState loadState,
    @Default(false) bool loading,
    @Default(<CameraDescription>[]) List<CameraDescription> cameras,
    CameraController? cameraController,
    @Default("") String secretKey,

  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}
enum PageEventType { navigationHome,error}

