part of 'create_product_ad_cubit.dart';

@freezed
class CreateProductAdBuildable with _$CreateProductAdBuildable {
  const factory CreateProductAdBuildable({
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<XFile>? pickedImages,
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
