part of 'request_ad_creation_cubit.dart';

@freezed
class RequestAdCreationState with _$RequestAdCreationState {
  const factory RequestAdCreationState({
    @Default(true) bool isFirstTime,
//
    int? adId,
    @Default(false) bool isEditing,
    @Default(true) bool isNotPrepared,
    @Default(false) bool isPreparingInProcess,
    //
    @Default(AdTransactionType.BUY) AdTransactionType adTransactionType,
    @Default(AdType.PRODUCT) AdType adType,
//
    @Default("") String title,
    Category? category,
//
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<UploadableFile>? pickedImages,
//
    @Default("") String desc,
    int? fromPrice,
    int? toPrice,
    Currency? currency,
    @Default([]) List<PaymentTypeResponse> paymentTypes,
    @Default(false) bool isAgreedPrice,
//
    @Default("") String contactPerson,
    @Default("") String phone,
    @Default("") String email,
//
    UserAddress? address,
    @Default(false) bool isShowAllRequestDistricts,
    @Default([]) List<District> requestDistricts,
//
    @Default(false) bool isAutoRenewal,
//
    @Default(false) bool isRequestSending,
//
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _RequestAdCreationState;
}

@freezed
class RequestAdCreationEvent with _$RequestAdCreationEvent {
  const factory RequestAdCreationEvent(
    RequestAdCreationEventType type, {
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
  }) = _RequestAdCreationEvent;
}

enum RequestAdCreationEventType { onOverMaxCount, onAdCreated }

const int MAX_IMAGE_COUNT = 5;
