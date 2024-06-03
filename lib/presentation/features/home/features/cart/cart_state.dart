part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(LoadingState.loading) LoadingState cartAdsState,
    @Default(<Ad>[]) List<Ad> cardAds,
  }) = _CartState;
}

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent() = _CartEvent;
}
