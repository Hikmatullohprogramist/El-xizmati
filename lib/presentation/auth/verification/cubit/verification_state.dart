part of 'verification_cubit.dart';

@freezed
class VerificationBuildable with _$VerificationBuildable {
  const factory VerificationBuildable({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool loading,
    @Default(false) bool enable,
  }) = _VerificationBuildable;
}

@freezed
class VerificationListenable with _$VerificationListenable {
  const factory VerificationListenable(VerificationEffect effect, {String? message}) = _VerificationListenable;
}

enum VerificationEffect { navigationToHome, navigationToConfirm }
