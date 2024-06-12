part of 'payment_transactions_cubit.dart';

@freezed
class PaymentTransactionsState with _$PaymentTransactionsState {
  const factory PaymentTransactionsState({
    @Default(LoadingState.loading) LoadingState transactionState,
    PagingController<int, PaymentTransaction>? controller,
  }) = _PaymentTransactionsState;
}

@freezed
class PaymentTransactionsEvent with _$PaymentTransactionsEvent {
  const factory PaymentTransactionsEvent() = _PaymentTransactionsEvent;
}
