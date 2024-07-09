part of 'reset_password_cubit.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
//
    @Default("") String password,
    @Default("") String repeatPassword,
//
    @Default(false) bool enabled,
    @Default(false) bool loading,
//
  }) = _ResetPasswordState;
}

@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent(ResetPasswordEventType type) =
      _ResetPasswordEvent;
}

enum ResetPasswordEventType { navigationToHome }
