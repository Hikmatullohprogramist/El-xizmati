part of 'auth_start_cubit.dart';

@freezed
class AuthStartState with _$AuthStartState {
  const factory AuthStartState(
      {@Default("") String phone,
      @Default(false) bool validation,
      @Default(false) bool oriflameCheckBox,
      @Default(false) bool loading,
      }) = _AuthStartState;
}

@freezed
class AuthStartEvent with _$AuthStartEvent {
  const factory AuthStartEvent(AuthStartEventType type, {String? phone}) =
      _AuthStartEvent;
}

enum AuthStartEventType {
  onOTPConfirm,
}
