part of 'auth_verification_cubit.dart';

@freezed
class AuthVerificationBuildable with _$AuthVerificationBuildable {
  const factory AuthVerificationBuildable() = _AuthVerificationBuildable;
}

@freezed
class AuthVerificationListenable with _$AuthVerificationListenable {
  const factory AuthVerificationListenable(Effect effect, {String? message}) =
      _AuthVerificationListenable;
}

enum Effect { success }
