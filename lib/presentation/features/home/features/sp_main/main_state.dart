part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({@Default('') String something}) = _MainState;
}
@freezed
class MainEvent with _$MainEvent{
  const factory MainEvent(MainEventType type) = _MainEvent;
}

enum MainEventType { onCreateAd }