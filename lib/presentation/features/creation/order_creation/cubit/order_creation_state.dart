part of 'order_creation_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  const factory PageState({
    int? adId,
    AdDetail? adDetail,
    @Default(false) bool favorite,
//
    @Default(0) double depositBalance,
    @Default(LoadingState.loading) LoadingState depositState,
//
    @Default(1) int paymentId,
    @Default(<int>[]) List<int> paymentType,
    @Default(1) int count,
    @Default(false) bool hasRangePrice,
    int? price,
//
    @Default(false) bool isRequestSending,
  }) = _PageState;

  double get actualDepositBalance {
    var totalPrice = hasRangePrice ? (price ?? 0) : count * adDetail!.price;
    return depositBalance >= totalPrice
        ? depositBalance
        : depositBalance - totalPrice;
  }

  int get totalPrice {
    return hasRangePrice ? (price ?? 0) : count * adDetail!.price;
  }
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type, {String? message}) = _PageEvent;
}

enum PageEventType {
  onBackAfterRemove,
  onOpenAfterCreation,
  onOpenAuthStart,
  onFailedOrderCreation,
  // onFailedIdentityNotVerified,
}
