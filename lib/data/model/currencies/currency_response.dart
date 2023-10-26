import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_response.freezed.dart';

part 'currency_response.g.dart';

@freezed
class CurrencyRootResponse with _$CurrencyRootResponse {
  const factory CurrencyRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    List<CurrencyResponse>? data,
    dynamic response,
  }) = _CurrencyRootResponse;

  factory CurrencyRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRootResponseFromJson(json);
}

@freezed
class CurrencyResponse with _$CurrencyResponse {
  const factory CurrencyResponse({
    String? id,
    String? name,
  }) = _CurrencyResponse;

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrencyResponseFromJson(json);
}
