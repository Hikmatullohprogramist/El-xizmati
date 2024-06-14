import 'package:freezed_annotation/freezed_annotation.dart';

part 'billing_transaction_response.freezed.dart';
part 'billing_transaction_response.g.dart';

@freezed
class BillingTransactionRootResponse with _$BillingTransactionRootResponse {
  const factory BillingTransactionRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required PaymentTransactionDataResponse data,
    dynamic response,
  }) = _BillingTransactionRootResponse;

  factory BillingTransactionRootResponse.fromJson(Map<String, dynamic> json) =>
      _$BillingTransactionRootResponseFromJson(json);
}

@freezed
class PaymentTransactionDataResponse with _$PaymentTransactionDataResponse {
  const factory PaymentTransactionDataResponse({
    int? count,
    required List<BillingTransactionResponse> results,
  }) = _PaymentTransactionDataResponse;

  factory PaymentTransactionDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionDataResponseFromJson(json);
}

@freezed
class BillingTransactionResponse with _$BillingTransactionResponse {
  const factory BillingTransactionResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "pay_date") String? payDate,
    @JsonKey(name: "type") String? transactionType,
    @JsonKey(name: "asum") dynamic amount,
    @JsonKey(name: "pay_status") String? payStatus,
    @JsonKey(name: "doc_type") String? transactionAction,
    @JsonKey(name: "saldo_state") String? balanceState,
    @JsonKey(name: "note") String? note,
  }) = _BillingTransactionResponse;

  factory BillingTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$BillingTransactionResponseFromJson(json);
}

// [
//   {
//     "id": 5734,
//     "pay_date": "27.05.2024 - 17:33",
//     "type": "HOLD",
//     "asum": 1400.0,
//     "doc_type": "PAYMENT",
//     "saldo_state": "CALCULATED",
//     "note": "№6250 рақамли буюрма учун олинган тўлов миқдори !"
//   },
//   {
//     "id": 5719,
//     "pay_date": "27.05.2024 - 17:12",
//     "type": "DEBIT",
//     "asum": 1000.0,
//     "doc_type": "BY_WALLET",
//     "saldo_state": "CALCULATED",
//     "note": "RealPay тўлов бўйича тин:31902922210014 ид: R04QH0008165"
//   }
// ]
