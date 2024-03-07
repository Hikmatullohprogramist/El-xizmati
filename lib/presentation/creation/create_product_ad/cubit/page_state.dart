part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String title,
    CategoryResponse? category,
//
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<XFile>? pickedImages,
    @Default("") String videoUrl,
//
    @Default("") String desc,
    int? warehouseCount,
    UnitResponse? unit,
    @Default(1) int minAmount,
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
    @Default(false) bool isPickupEnabled,
    @Default([]) List<UserAddressResponse> pickupWarehouses,
    @Default(false) bool isFreeDeliveryEnabled,
    @Default(5) int freeDeliveryMaxDay,
    @Default([]) List<District> freeDeliveryDistricts,
    @Default(false) bool isPaidDeliveryEnabled,
    @Default(5) int paidDeliveryMaxDay,
    @Default([]) List<District> paidDeliveryDistricts,
//
    @Default(false) bool isAutoRenewal,
//
    @Default(false) bool isShowMySocialAccount,
    @Default(false) bool isRequestSending,
//
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
