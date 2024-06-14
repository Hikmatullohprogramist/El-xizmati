part of 'one_id_cubit.dart';

@freezed
class OneIdState with _$OneIdState {
  const OneIdState._();

  const factory OneIdState({
    @Default(LoadingState.none) LoadingState loginState,
    @Default(LoadingState.loading) LoadingState pageState,
  }) = _OneIdState;

  bool get isPageLoadingInProgress => pageState == LoadingState.loading;

  bool get isPageLoadingFinished => pageState == LoadingState.success;

  bool get isPageLoadingFailed => pageState == LoadingState.error;
}

@freezed
class OneIdEvent with _$OneIdEvent {
  const factory OneIdEvent(OneIdEventType effect, {String? message}) = _OneIdEvent;
}

enum OneIdEventType { onStartPageLoading, onSuccessLogin }
