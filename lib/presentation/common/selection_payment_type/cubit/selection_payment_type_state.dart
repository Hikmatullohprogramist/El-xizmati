part of 'selection_payment_type_cubit.dart';

@freezed
class SelectionPaymentTypeBuildable with _$SelectionPaymentTypeBuildable {
  const factory SelectionPaymentTypeBuildable({
    @Default(<PaymentTypeResponse>[]) List<PaymentTypeResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
    @Default(<PaymentTypeResponse>[]) List<PaymentTypeResponse> selectedItems,
  }) = _SelectionPaymentTypeBuildable;
}

@freezed
class SelectionPaymentTypeListenable with _$SelectionPaymentTypeListenable {
  const factory SelectionPaymentTypeListenable() =
      _SelectionPaymentTypeListenable;
}
