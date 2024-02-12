part of 'create_product_order_cubit.dart';

@freezed
class CreateProductOrderBuildable with _$CreateProductOrderBuildable {
  const factory CreateProductOrderBuildable({
    String? name,
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
    @Default(false) bool isNegotiate,
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<XFile>? pickedImages,
  }) = _ProductOrderCreateBuildable;
}

@freezed
class CreateProductOrderListenable with _$CreateProductOrderListenable {
  const factory CreateProductOrderListenable(
    CreateProductOrderEffect effect, {
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
  }) = _ProductOrderCreateListenable;
}

enum CreateProductOrderEffect { selectCategory, onOverMaxCount }

const int MAX_IMAGE_COUNT = 5;
