part of 'set_password_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String password,
    @Default("") String repeatPassword,
    @Default(false) bool enabled,
    @Default(false) bool loading,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { navigationToHome }
