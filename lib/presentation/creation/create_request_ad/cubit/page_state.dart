part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    int? adId,
    @Default(false) bool isEditing,
    @Default(false) bool isPrepared,
    @Default(false) bool isPreparingInProcess,
    //
    @Default(AdTransactionType.BUY) AdTransactionType adTransactionType,
    @Default(AdType.product) AdType adType,
//
    @Default("") String title,
    CategoryResponse? category,
//
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<UploadableFile>? pickedImages,
//
    @Default("") String desc,
    int? fromPrice,
    int? toPrice,
    CurrencyResponse? currency,
    @Default([]) List<PaymentTypeResponse> paymentTypes,
    @Default(false) bool isAgreedPrice,
//
    UserAddressResponse? address,
    @Default("") String contactPerson,
    @Default("") String phone,
    @Default("") String email,
//
    @Default(false) bool isShowAllRequestDistricts,
    @Default([]) List<District> requestDistricts,
//
    @Default(false) bool isAutoRenewal,
//
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

enum PageEventType { onOverMaxCount, onAdCreated }

const int MAX_IMAGE_COUNT = 5;
