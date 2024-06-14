part of 'billing_transactions_cubit.dart';

@freezed
class BillingTransactionsState with _$BillingTransactionsState {
  const factory BillingTransactionsState({
    @Default(LoadingState.loading) LoadingState transactionState,
    PagingController<int, BillingTransaction>? controller,
  }) = _BillingTransactionsState;
}

@freezed
class BillingTransactionsEvent with _$BillingTransactionsEvent {
  const factory BillingTransactionsEvent() = _BillingTransactionsEvent;
}
