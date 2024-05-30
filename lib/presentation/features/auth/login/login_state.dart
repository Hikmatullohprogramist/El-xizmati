part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    @Default("") String phone,
    @Default('') String password,
    @Default(false) bool isRequestSending,
  }) = _LoginState;
}

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent(LoginEventType type, {String? message}) =
      _LoginEvent;
}

enum LoginEventType {
  onOpenAuthConfirm,
  onOpenHome,
  onLoginFailed,
}
