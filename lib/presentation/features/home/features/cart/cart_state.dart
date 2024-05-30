part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(LoadingState.loading) LoadingState loadState,
    @Default(<Ad>[]) List<Ad> items,
  }) = _CartState;
}

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent() = _CartEvent;
}
