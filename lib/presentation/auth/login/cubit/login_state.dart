part of 'login_cubit.dart';

@freezed
class LoginBuildable with _$LoginBuildable {
  const LoginBuildable._();

  const factory LoginBuildable(
      {@Default(false) bool loading,
      @Default('') String phone,
      @Default('') String password,
      @Default(false) bool enabled}) = _LoginBuildable;
}

@freezed
class LoginListenable with _$LoginListenable {
  const factory LoginListenable(
    LoginEffect effect, {
    String? phone,
  }) = _LoginListenable;
}

enum LoginEffect { success }
