part of 'refill_with_realpay_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(true) bool isLoading,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType effect,
      {String? message}) = _PageEvent;
}

enum PageEventType { onSuccessLogin }
