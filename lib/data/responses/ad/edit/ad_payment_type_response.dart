import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_payment_type_response.freezed.dart';
part 'ad_payment_type_response.g.dart';

@freezed
class AdPaymentTypeResponse with _$AdPaymentTypeResponse {
  const factory AdPaymentTypeResponse({
    required int id,
    required String? name,
  }) = _AdPaymentTypeResponse;

  factory AdPaymentTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$AdPaymentTypeResponseFromJson(json);
}
