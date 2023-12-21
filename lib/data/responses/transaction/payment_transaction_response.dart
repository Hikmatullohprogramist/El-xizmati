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
   required Data data,
    dynamic response,
  }) = _PaymentTransactionRootResponse;

  factory PaymentTransactionRootResponse.fromJson(Map<String, dynamic> json) => _$PaymentTransactionRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    int? count,
   required List<dynamic> results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
