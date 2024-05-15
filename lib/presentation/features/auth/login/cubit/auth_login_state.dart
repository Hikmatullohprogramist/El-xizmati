part of 'auth_login_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState({
    @Default("") String phone,
    @Default('') String password,
    @Default(false) bool isRequestSending,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type, {String? message}) = _PageEvent;
}

enum PageEventType {
  onOpenAuthConfirm,
  onOpenHome,
  onLoginFailed,
}
