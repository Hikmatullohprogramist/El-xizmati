part of 'otp_confirmation_cubit.dart';

@freezed
class OtpConfirmationState with _$OtpConfirmationState {
  const OtpConfirmationState._();

  const factory OtpConfirmationState({
//
    @Default("") String phone,
    @Default("") String sessionToken,
    @Default(OtpConfirmType.forRegister) OtpConfirmType otpConfirmType,
//
    @Default(120) int timerTime,
//
    @Default('') String otpCode,
//
    @Default(false) bool isResendLoading,
    @Default(false) bool isConfirmLoading,
//
    @Default("") String secretKey,
//
  }) = _OtpConfirmationState;

  bool get isResentButtonEnabled => timerTime == 0;

  bool get isConfirmButtonEnabled => otpCode.length >= 4;
}

@freezed
class OtpConfirmationEvent with _$OtpConfirmationEvent {
  const factory OtpConfirmationEvent(OtpConfirmationEventType type) =
      _OtpConfirmationEvent;
}

enum OtpConfirmationEventType {
  onOpenResetPassword,
  onOpenRegistrationRoute,
  onOpenHome
}
