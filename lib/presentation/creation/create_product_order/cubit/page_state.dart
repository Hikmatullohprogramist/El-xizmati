part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    String? name,
    CategoryResponse? categoryResponse,
    UserAddressResponse? userAddressResponse,
    int? categoryId,
    String? description,
    @Default(<String>[]) List photos,
    String? fromPrice,
    String? toPrice,
    String? currency,
//
    UserAddressResponse? address,
    String? phone,
    String? email,
    @Default(false) bool validation,

//
    @Default(false) bool isAutoRenewal,

//
    @Default([]) List<PaymentTypeResponse> paymentTypes,
//
    CurrencyResponse? currenc,
    @Default(false) bool isNegotiate,
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<XFile>? pickedImages,
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
