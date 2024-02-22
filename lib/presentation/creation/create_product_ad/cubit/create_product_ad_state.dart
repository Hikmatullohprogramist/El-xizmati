part of 'create_product_ad_cubit.dart';

@freezed
class CreateProductAdBuildable with _$CreateProductAdBuildable {
  const factory CreateProductAdBuildable({
    @Default("") String title,
    CategoryResponse? category,
//
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<XFile>? pickedImages,
//
    @Default("") String desc,
    int? warehouseCount,
    UnitResponse? unit,
    int? price,
    CurrencyResponse? currency,
    @Default([]) List<PaymentTypeResponse> paymentTypes,
    @Default(false) bool isAgreedPrice,
//
    @Default(true) bool isNew,
    @Default(false) bool isBusiness,
//
    UserAddressResponse? address,
    @Default("") String contactPerson,
    @Default("") String phone,
    @Default("") String email,
//
    @Default(false) bool isAutoRenewal,
//
    @Default(false) bool isShowMySocialAccount,
    @Default(false) bool isRequestSending,
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
