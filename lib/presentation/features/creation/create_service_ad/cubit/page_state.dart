part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(true) bool isFirstTime,
//
    int? adId,
    @Default(false) bool isEditing,
    @Default(true) bool isNotPrepared,
    @Default(false) bool isPreparingInProcess,
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
