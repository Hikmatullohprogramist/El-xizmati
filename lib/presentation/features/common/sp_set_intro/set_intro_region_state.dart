part of 'set_intro_region_cubit.dart';

@freezed
class SetIntroState with _$SetIntroState {
  const factory SetIntroState() = _SetIntroState;
}

@freezed
class SetIntroEvent with _$SetIntroEvent {
  const factory SetIntroEvent(SetIntroEventType type) = _SetIntroEvent;
}

enum SetIntroEventType { onSkip, onSet }
