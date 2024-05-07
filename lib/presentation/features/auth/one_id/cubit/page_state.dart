part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(true) bool isLoading,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType effect, {String? message}) = _PageEvent;
}

enum PageEventType { onSuccessLogin }
