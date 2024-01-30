part of 'create_product_ad_cubit.dart';

@freezed
class CreateProductAdBuildable with _$CreateProductAdBuildable {
  const factory CreateProductAdBuildable({
    @Default(5) int maxImageCount,
    List<XFile>? pickedImages,
  }) = _CreateProductAdBuildable;
}

@freezed
class CreateProductAdListenable with _$CreateProductAdListenable {
  const factory CreateProductAdListenable(
    CreateProductAdEffect effect, {
    String? message,
  }) = _CreateProductAdListenable;
}

enum CreateProductAdEffect { onMaxCount }
