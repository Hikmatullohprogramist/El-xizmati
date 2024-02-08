part of 'create_product_order_cubit.dart';

@freezed
class CreateProductOrderBuildable with _$ProductOrderCreateBuildable {
  const factory CreateProductOrderBuildable(
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
class CreateProductOrderListenable with _$ProductOrderCreateListenable {
  const factory CreateProductOrderListenable(
          ProductOrderCreateEffect productOrderCreateEffect) =
      _ProductOrderCreateListenable;
}

enum ProductOrderCreateEffect { selectCategory }
