part of 'payment_transaction_filter_cubit.dart';

@freezed
class PaymentTransactionFilterState with _$PaymentTransactionFilterState {
  const factory PaymentTransactionFilterState({
    @Default("") String fromDate,
    @Default("") String toDate,
    @Default("") String paymentType,
    @Default("") String paymentMethod,
    @Default("") String transactionState,
    //
    @Default(<PaymentFilter>[]) List<PaymentFilter> paymentTypes,
    @Default(<PaymentFilter>[]) List<PaymentFilter> paymentMethods,
    @Default(<PaymentFilter>[]) List<PaymentFilter> transactionStates,
    //
    @Default([]) List<PaymentTransaction> transactions,
  }) = _PaymentTransactionFilterState;
}

@freezed
class PaymentTransactionFilterEvent with _$PaymentTransactionFilterEvent {
  const factory PaymentTransactionFilterEvent() =
      _PaymentTransactionFilterEvent;
}
