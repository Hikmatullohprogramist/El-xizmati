part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool loading,
    @Default(ConfirmType.confirm) ConfirmType confirmType,
    @Default(120) int timerTime,
  }) = _PageState;

  bool get againButtonEnable => timerTime == 0;

  bool get enable => code.length == 4;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { setPassword }
