part of 'refill_with_realpay_cubit.dart';

@freezed
class RefillWithRealpayState with _$RefillWithRealpayState {
  const factory RefillWithRealpayState({
    @Default(true) bool isLoading,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _RefillWithRealpayState;
}

@freezed
class RefillWithRealpayEvent with _$RefillWithRealpayEvent {
  const factory RefillWithRealpayEvent() = _RefillWithRealpayEvent;
}
