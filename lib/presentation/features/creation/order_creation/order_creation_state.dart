part of 'order_creation_cubit.dart';

@freezed
class OrderCreationState with _$OrderCreationState {
  const OrderCreationState._();

  const factory OrderCreationState({
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
  }) = _OrderCreationState;

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
class OrderCreationEvent with _$OrderCreationEvent {
  const factory OrderCreationEvent(OrderCreationEventType type,
      {String? message}) = _OrderCreationEvent;
}

enum OrderCreationEventType {
  onBackAfterRemove,
  onAfterCreation,
  onOpenAuthStart,
  onFailedOrderCreation,
}
