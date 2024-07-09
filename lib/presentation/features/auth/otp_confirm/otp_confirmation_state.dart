part of 'otp_confirmation_cubit.dart';

@freezed
class OtpConfirmationState with _$OtpConfirmationState {
  const OtpConfirmationState._();

  const factory OtpConfirmationState({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool isResendLoading,
    @Default(false) bool isConfirmLoading,
    @Default(OtpConfirmType.registerConfirm) OtpConfirmType otpConfirmType,
    @Default(120) int timerTime,
  }) = _OtpConfirmationState;

  bool get isResentButtonEnabled => timerTime == 0;

  bool get isConfirmButtonEnabled => code.length == 4;
}

@freezed
class OtpConfirmationEvent with _$OtpConfirmationEvent {
  const factory OtpConfirmationEvent(OtpConfirmationEventType type) =
      _OtpConfirmationEvent;
}

enum OtpConfirmationEventType {
  onOpenResetPassword,
  onOpenIdentityVerification,
}
