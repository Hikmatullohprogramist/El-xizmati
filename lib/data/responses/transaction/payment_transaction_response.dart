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

  factory PaymentTransactionRootResponse.fromJson(Map<String, dynamic> json) => _$PaymentTransactionRootResponseFromJson(json);
}

@freezed
class PaymentTransactionDataResponse with _$PaymentTransactionDataResponse {
  const factory PaymentTransactionDataResponse({
    int? count,
   required List<PaymentTransactionResponse> results,
  }) = _PaymentTransactionDataResponse;

  factory PaymentTransactionDataResponse.fromJson(Map<String, dynamic> json) => _$PaymentTransactionDataResponseFromJson(json);
}

@freezed
class PaymentTransactionResponse with _$PaymentTransactionResponse {
  const factory PaymentTransactionResponse({
    required int id,
    required String pay_date,
    required String type,
    required dynamic amount,
    required String pay_status,
    required String pay_method,
    required String pay_type,
    String? note,
  }) = _PaymentTransactionResponse;

  factory PaymentTransactionResponse.fromJson(Map<String, dynamic> json) => _$PaymentTransactionResponseFromJson(json);
}
