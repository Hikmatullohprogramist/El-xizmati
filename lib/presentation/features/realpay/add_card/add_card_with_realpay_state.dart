part of 'add_card_with_realpay_cubit.dart';

@freezed
class AddCardWithRealpayState with _$AddCardWithRealpayState {
  const factory AddCardWithRealpayState({
    @Default(true) bool isLoading,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _AddCardWithRealpayState;
}

@freezed
class AddCardWithRealpayEvent with _$AddCardWithRealpayEvent {
  const factory AddCardWithRealpayEvent() = _AddCardWithRealpayEvent;
}
