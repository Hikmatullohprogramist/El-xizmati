part of 'cart_cubit.dart';

@freezed
class CartBuildable with _$CartBuildable {
  const factory CartBuildable() = _CartBuildable;
}

@freezed
class CartListenable with _$CartListenable {
  const factory CartListenable(CartEffect effect, {String? message}) =
  _CartListenable;
}

enum CartEffect { success }