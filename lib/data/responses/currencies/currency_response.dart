import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_response.freezed.dart';
part 'currency_response.g.dart';

@freezed
class CurrencyRootResponse with _$CurrencyRootResponse {
  const factory CurrencyRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<Currency> data,
    dynamic response,
  }) = _CurrencyRootResponse;

  factory CurrencyRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRootResponseFromJson(json);
}

@freezed
class Currency with _$Currency {
  const factory Currency({
    required String id,
    String? name,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
}
