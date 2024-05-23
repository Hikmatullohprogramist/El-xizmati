part of 'auth_with_one_id_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState({
    @Default(LoadingState.onStart) LoadingState loginState,
    @Default(LoadingState.loading) LoadingState pageState,
  }) = _PageState;

  bool get isPageLoadingInProgress => pageState == LoadingState.loading;

  bool get isPageLoadingFinished => pageState == LoadingState.success;

  bool get isPageLoadingFailed => pageState == LoadingState.error;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType effect, {String? message}) = _PageEvent;
}

enum PageEventType { onStartPageLoading, onSuccessLogin }
