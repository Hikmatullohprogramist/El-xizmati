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
    required List<PaymentTransaction> results,
  }) = _PaymentTransactionDataResponse;

  factory PaymentTransactionDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionDataResponseFromJson(json);
}

@freezed
class PaymentTransaction with _$PaymentTransaction {
  const factory PaymentTransaction({
    required int id,
    required String pay_date,
    required String type,
    required dynamic amount,
    required String pay_status,
    required String pay_method,
    required String pay_type,
    String? note,
  }) = _PaymentTransaction;

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionFromJson(json);
}
