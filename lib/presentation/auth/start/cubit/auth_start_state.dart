part of 'auth_start_cubit.dart';

@freezed
class AuthStartBuildable with _$AuthStartBuildable {
  const factory AuthStartBuildable({
    @Default("") String phone,
    @Default(false) bool validation,
    @Default(false) bool loading,
    @Default(true) backButtonVisible,
  }) = _AuthStartBuildable;
}

@freezed
class AuthStartListenable with _$AuthStartListenable {
  const factory AuthStartListenable(AuthStartEffect effect, {String? phone}) =
      _AuthStartListenable;
}

enum AuthStartEffect { verification, confirmation}
