part of 'auth_confirm_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool isResendLoading,
    @Default(false) bool isConfirmLoading,
    @Default(ConfirmType.confirm) ConfirmType confirmType,
    @Default(120) int timerTime,
  }) = _PageState;

  bool get isResentButtonEnabled => timerTime == 0;

  bool get isConfirmButtonEnabled => code.length == 4;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { setPassword }
