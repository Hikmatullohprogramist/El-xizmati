part of 'selection_currency_cubit.dart';

@freezed
class SelectionCurrencyBuildable with _$SelectionCurrencyBuildable {
  const factory SelectionCurrencyBuildable({
    @Default(<CurrencyResponse>[]) List<CurrencyResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _SelectionCurrencyBuildable;
}

@freezed
class SelectionCurrencyListenable with _$SelectionCurrencyListenable {
  const factory SelectionCurrencyListenable() = _SelectionCurrencyListenable;
}