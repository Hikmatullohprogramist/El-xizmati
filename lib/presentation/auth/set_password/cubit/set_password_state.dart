part of 'set_password_cubit.dart';

@freezed
class SetPasswordBuildable with _$SetPasswordBuildable {
  const factory SetPasswordBuildable(
      {@Default("") String password,
      @Default("") String repeatPassword,
      @Default(false) bool enabled,
      @Default(false) bool loading}) = _SetPasswordBuildable;
}

@freezed
class SetPasswordListenable with _$SetPasswordListenable {
  const factory SetPasswordListenable(SetPasswordEffect effect,
      {String? message}) = _SetPasswordListenable;
}

enum SetPasswordEffect { navigationToHome }
