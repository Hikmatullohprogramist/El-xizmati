part of 'auth_start_cubit.dart';

@freezed
class AuthStartBuildable with _$AuthStartBuildable {
  const factory AuthStartBuildable() = _AuthStartBuildable;
}

@freezed
class AuthStartListenable with _$AuthStartListenable {
  const factory AuthStartListenable(AuthStartEffect effect, {String? message}) =
      _AuthStartListenable;
}

enum AuthStartEffect { success }
