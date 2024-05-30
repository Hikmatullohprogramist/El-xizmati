part of 'currency_selection_cubit.dart';

@freezed
class CurrencySelectionState with _$CurrencySelectionState {
  const factory CurrencySelectionState({
    @Default(<Currency>[]) List<Currency> items,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _CurrencySelectionState;
}

@freezed
class CurrencySelectionEvent with _$CurrencySelectionEvent {
  const factory CurrencySelectionEvent() = _CurrencySelectionEvent;
}
