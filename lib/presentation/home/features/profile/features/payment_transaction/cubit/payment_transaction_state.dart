part of 'payment_transaction_cubit.dart';

@freezed
class PaymentTransactionBuildable with _$PaymentTransactionBuildable {
  const factory PaymentTransactionBuildable({
    @Default(LoadingState.loading) LoadingState transactionState,
    PagingController<int, dynamic>? transactionPagingController,
  }) = _PaymentTransactionBuildable;
}

@freezed
class PaymentTransactionListenable with _$PaymentTransactionListenable {
  const factory PaymentTransactionListenable(PaymentTransactionEffect effect,
      {String? message}) = _PaymentTransactionListenable;
}

enum PaymentTransactionEffect { success }
