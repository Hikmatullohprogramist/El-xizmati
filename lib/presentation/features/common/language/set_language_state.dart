part of 'set_language_cubit.dart';

@freezed
class SetLanguageState with _$SetLanguageState {
  const factory SetLanguageState() = _SetLanguageState;
}

@freezed
class SetLanguageEvent with _$SetLanguageEvent {
  const factory SetLanguageEvent(SetLanguageEventType type) = _SetLanguageEvent;
}

enum SetLanguageEventType { navigationAuthStart }
