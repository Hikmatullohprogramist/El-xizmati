part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isAuthorized,
    Language? language,
  }) = _ProfileState;
}

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent(ProfileEventType type) = _ProfileEvent;
}

enum ProfileEventType { onLogOut }
