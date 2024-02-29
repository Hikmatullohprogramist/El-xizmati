part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
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
    @Default([]) List<RegionResponse> paymentType,
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
    @Default(false) bool isPickupEnabled,
    @Default([]) List<UserAddressResponse> pickupAddresses,
    @Default(false) bool isFreeDeliveryEnabled,
    @Default(false) bool isPaidDeliveryEnabled,
//
    @Default(false) bool isAutoRenewal,
//
    @Default(false) bool isShowMySocialAccount,
    @Default(false) bool isRequestSending,
//
    @Default(<RegionResponse>[]) List<RegionResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(
    PageEventType type, {
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
  }) = _PageEvent;
}

enum PageEventType { onOverMaxCount }

const int MAX_IMAGE_COUNT = 5;
