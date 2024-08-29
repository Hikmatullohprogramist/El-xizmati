part of 'ad_create_cubit.dart';
@freezed
class AdCreateState with _$AdCreateState {
  const factory AdCreateState({@Default('') String something}) = _AdCreateState;
}
@freezed
class AdCreateEvent with _$AdCreateEvent{
  const factory AdCreateEvent() = _AdCreateEvent;
}
