part of 'create_product_ad_cubit.dart';

@freezed
class CreateProductAdBuildable with _$CreateProductAdBuildable {
  const factory CreateProductAdBuildable({
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<XFile>? pickedImages,
    CategoryResponse? category,
    UserAddressResponse? address,
    UnitResponse? unit,
    @Default(false) bool isAgreedPrice,
    @Default(false) bool isAutoRenewal,
    @Default(false) bool isShowMySocialAccount,
  }) = _CreateProductAdBuildable;
}

@freezed
class CreateProductAdListenable with _$CreateProductAdListenable {
  const factory CreateProductAdListenable(
    CreateProductAdEffect effect, {
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
  }) = _CreateProductAdListenable;
}

enum CreateProductAdEffect { onOverMaxCount }

const int MAX_IMAGE_COUNT = 5;
