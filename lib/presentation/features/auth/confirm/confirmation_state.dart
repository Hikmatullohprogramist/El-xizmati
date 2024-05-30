part of 'confirmation_cubit.dart';

@freezed
class ConfirmationState with _$ConfirmationState {
  const ConfirmationState._();

  const factory ConfirmationState({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool isResendLoading,
    @Default(false) bool isConfirmLoading,
    @Default(ConfirmType.confirm) ConfirmType confirmType,
    @Default(120) int timerTime,
  }) = _ConfirmationState;

  bool get isResentButtonEnabled => timerTime == 0;

  bool get isConfirmButtonEnabled => code.length == 4;
}

@freezed
class ConfirmationEvent with _$ConfirmationEvent {
  const factory ConfirmationEvent(ConfirmationEventType type) =
      _ConfirmationEvent;
}

enum ConfirmationEventType { setPassword }
