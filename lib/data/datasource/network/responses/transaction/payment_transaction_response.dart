import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_transaction_response.freezed.dart';
part 'payment_transaction_response.g.dart';

@freezed
class PaymentTransactionRootResponse with _$PaymentTransactionRootResponse {
  const factory PaymentTransactionRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required PaymentTransactionDataResponse data,
    dynamic response,
  }) = _PaymentTransactionRootResponse;

  factory PaymentTransactionRootResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionRootResponseFromJson(json);
}

@freezed
class PaymentTransactionDataResponse with _$PaymentTransactionDataResponse {
  const factory PaymentTransactionDataResponse({
    int? count,
    required List<PaymentTransactionResponse> results,
  }) = _PaymentTransactionDataResponse;

  factory PaymentTransactionDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionDataResponseFromJson(json);
}

@freezed
class PaymentTransactionResponse with _$PaymentTransactionResponse {
  const factory PaymentTransactionResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "pay_date") String? payDate,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "asum") dynamic amount,
    @JsonKey(name: "pay_status") String? payStatus,
    @JsonKey(name: "doc_type") String? payMethod,
    @JsonKey(name: "saldo_state") String? payType,
    @JsonKey(name: "note") String? note,
  }) = _PaymentTransactionResponse;

  factory PaymentTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionResponseFromJson(json);
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
