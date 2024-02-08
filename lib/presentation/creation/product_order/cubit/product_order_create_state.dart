part of 'product_order_create_cubit.dart';

@freezed
class ProductOrderCreateBuildable with _$ProductOrderCreateBuildable {
  const factory ProductOrderCreateBuildable(
      {String? name,
      CategoryResponse? categoryResponse,
      UserAddressResponse? userAddressResponse,
      int? categoryId,
      String? description,
      @Default(<String>[]) List photos,
      String? fromPrice,
      String? toPrice,
      String? currency,
      String? phone,
      String? email,
      @Default(false) bool isNegotiate}) = _ProductOrderCreateBuildable;
}

@freezed
class ProductOrderCreateListenable with _$ProductOrderCreateListenable {
  const factory ProductOrderCreateListenable(
          ProductOrderCreateEffect productOrderCreateEffect) =
      _ProductOrderCreateListenable;
}

enum ProductOrderCreateEffect { selectCategory }
