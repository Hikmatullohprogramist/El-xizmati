part of 'selection_payment_type_cubit.dart';

@freezed
class SelectionPaymentTypeBuildable with _$SelectionPaymentTypeBuildable {
  const factory SelectionPaymentTypeBuildable({
    @Default(<PaymentTypeResponse>[]) List<PaymentTypeResponse> paymentTypes,
    @Default(LoadingState.loading) LoadingState paymentTypesState,
    @Default(<PaymentTypeResponse>[])
    List<PaymentTypeResponse> selectedPaymentTypes,
  }) = _SelectionPaymentTypeBuildable;
}

@freezed
class SelectionPaymentTypeListenable with _$SelectionPaymentTypeListenable {
  const factory SelectionPaymentTypeListenable() =
      _SelectionPaymentTypeListenable;
}
