part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState({
    @Default("") String phone,
    @Default('') String password,
    @Default(false) bool loading,
  }) = _PageState;

  bool get enable => password.length >= 8;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { navigationToConfirm, navigationHome }
