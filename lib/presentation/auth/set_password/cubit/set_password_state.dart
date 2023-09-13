part of 'set_password_cubit.dart';

@freezed
class SetPasswordBuildable with _$SetPasswordBuildable {
  const factory SetPasswordBuildable() = _SetPasswordBuildable;
}

@freezed
class SetPasswordListenable with _$SetPasswordListenable {
  const factory SetPasswordListenable(Effect effect, {String? message}) =
      _SetPasswordListenable;
}

enum Effect { success }
