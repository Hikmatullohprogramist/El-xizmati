part of 'billing_transaction_filter_cubit.dart';

@freezed
class BillingTransactionFilterState with _$BillingTransactionFilterState {
  const factory BillingTransactionFilterState({
    @Default("") String fromDate,
    @Default("") String toDate,
    @Default("") String paymentType,
    @Default("") String paymentMethod,
    @Default("") String transactionState,
    //
    @Default([]) List<BillingTransactionFilter> paymentTypes,
    @Default([]) List<BillingTransactionFilter> paymentMethods,
    @Default([]) List<BillingTransactionFilter> transactionStates,
    //
    @Default([]) List<BillingTransaction> transactions,
  }) = _BillingTransactionFilterState;
}

@freezed
class BillingTransactionFilterEvent with _$BillingTransactionFilterEvent {
  const factory BillingTransactionFilterEvent() =
      _BillingTransactionFilterEvent;
}
