part of 'auth_confirm_cubit.dart';

@freezed
class AuthBuildable with _$AuthBuildable {
  const factory AuthBuildable() = _AuthBuildable;
}

@freezed
class AuthListenable with _$AuthListenable {
  const factory AuthListenable(Effect effect, {String? message}) =
      _AuthListenable;
}

enum Effect { success }
