part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String fromDate,
    @Default("") String toDate,
    @Default("") String paymentType,
    @Default("") String paymentMethod,
    @Default("") String transactionState,
    @Default(<PaymentFilter>[]) List<PaymentFilter> paymentTypes,
    @Default(<PaymentFilter>[]) List<PaymentFilter> paymentMethods,
    @Default(<PaymentFilter>[]) List<PaymentFilter> transactionStates,
//
    @Default(<PaymentTransactionResponse>[]) List<PaymentTransactionResponse> transactionList,
//

  }) = _PPageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
