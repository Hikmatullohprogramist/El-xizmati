part of 'product_order_create_cubit.dart';

@freezed
class ProductOrderCreateBuildable with _$ProductOrderCreateBuildable {
  const factory ProductOrderCreateBuildable() = _ProductOrderCreateBuildable;
}

@freezed
class ProductOrderCreateListenable with _$ProductOrderCreateListenable {
  const factory ProductOrderCreateListenable({ProductOrderCreateEffect? productOrderCreateEffect}) = _ProductOrderCreateListenable;
}

enum ProductOrderCreateEffect{success}
