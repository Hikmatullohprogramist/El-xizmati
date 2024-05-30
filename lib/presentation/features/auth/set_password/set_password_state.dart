part of 'set_password_cubit.dart';

@freezed
class SetPasswordState with _$SetPasswordState {
  const factory SetPasswordState({
    @Default("") String password,
    @Default("") String repeatPassword,
    @Default(false) bool enabled,
    @Default(false) bool loading,
  }) = _SetPasswordState;
}

@freezed
class SetPasswordEvent with _$SetPasswordEvent {
  const factory SetPasswordEvent(SetPasswordEventType type) = _SetPasswordEvent;
}

enum SetPasswordEventType { navigationToHome }
