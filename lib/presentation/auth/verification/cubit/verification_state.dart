part of 'verification_cubit.dart';

@freezed
class VerificationBuildable with _$VerificationBuildable {
  const VerificationBuildable._();

  const factory VerificationBuildable({
    @Default("") String phone,
    @Default('') String password,
    @Default(false) bool loading,
  }) = _VerificationBuildable;

  bool get enable => password.length >= 8;
}

@freezed
class VerificationListenable with _$VerificationListenable {
  const factory VerificationListenable(VerificationEffect effect, {String? message}) = _VerificationListenable;
}

enum VerificationEffect { navigationToConfirm, navigationHome }
