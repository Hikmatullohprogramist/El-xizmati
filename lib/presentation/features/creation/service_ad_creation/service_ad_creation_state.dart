part of 'service_ad_creation_cubit.dart';

@freezed
class ServiceAdCreationState with _$ServiceAdCreationState {
  const factory ServiceAdCreationState({
    @Default(true) bool isFirstTime,
//
    int? adId,
    @Default(false) bool isEditing,
    @Default(true) bool isNotPrepared,
    @Default(false) bool isPreparingInProcess,
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
    @Default(false) bool isBusiness,
//
    UserAddress? address,
    @Default("") String contactPerson,
    @Default("") String phone,
    @Default("") String email,
//
    @Default(false) bool isShowAllServiceDistricts,
    @Default([]) List<District> serviceDistricts,
//
    @Default(false) bool isAutoRenewal,
    @Default(false) bool isShowMySocialAccount,
    @Default("") String videoUrl,
//
    @Default(false) bool isRequestSending,
//
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _ServiceAdCreationState;
}

@freezed
class ServiceAdCreationEvent with _$ServiceAdCreationEvent {
  const factory ServiceAdCreationEvent(
    ServiceAdCreationEventType type, {
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
  }) = _ServiceAdCreationEvent;
}

enum ServiceAdCreationEventType {
  onOverMaxCount,
  onRequestStarted,
  onRequestFinished,
  onRequestFailed,
}

const int MAX_IMAGE_COUNT = 5;
