import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'payment_type_response.freezed.dart';
part 'payment_type_response.g.dart';

@freezed
class PaymentTypeRootResponse with _$PaymentTypeRootResponse {
  const factory PaymentTypeRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<PaymentTypeResponse> data,
  }) = _PaymentTypeRootResponse;

  factory PaymentTypeRootResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeRootResponseFromJson(json);
}

@freezed
class PaymentTypeResponse with _$PaymentTypeResponse {
  @HiveType(typeId: 1)
  const factory PaymentTypeResponse({
    @HiveField(1) required int id,
    @HiveField(2) String? name,
  }) = _PaymentTypeResponse;

  factory PaymentTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentTypeResponseFromJson(json);
}
