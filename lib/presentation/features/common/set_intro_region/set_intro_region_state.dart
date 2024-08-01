part of 'set_intro_region_cubit.dart';

@freezed
class SetIntroRegionState with _$SetIntroRegionState {
  const factory SetIntroRegionState() = _SetIntroRegionState;
}

@freezed
class SetIntroRegionEvent with _$SetIntroRegionEvent {
  const factory SetIntroRegionEvent(SetIntroRegionEventType type) = _SetIntroRegionEvent;
}

enum SetIntroRegionEventType { onSkip, onSet }
