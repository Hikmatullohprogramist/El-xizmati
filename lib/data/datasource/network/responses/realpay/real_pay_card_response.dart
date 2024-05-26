import 'package:freezed_annotation/freezed_annotation.dart';

part 'real_pay_card_response.freezed.dart';
part 'real_pay_card_response.g.dart';

@freezed
class RealPayCardRootResponse with _$RealPayCardRootResponse {
  const factory RealPayCardRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required RealPayCardDataResponse data,
    dynamic response,
  }) = _RealPayCardRootResponse;

  factory RealPayCardRootResponse.fromJson(Map<String, dynamic> json) =>
      _$RealPayCardRootResponseFromJson(json);
}

@freezed
class RealPayCardDataResponse with _$RealPayCardDataResponse {
  const factory RealPayCardDataResponse({
    required List<RealPayCard> data,
    dynamic code,
    dynamic message,
  }) = _RealPayCardDataResponse;

  factory RealPayCardDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RealPayCardDataResponseFromJson(json);
}

@freezed
class RealPayCard with _$RealPayCard {
  const RealPayCard._();

  const factory RealPayCard({
    @JsonKey(name: "card_id") required String cardId,
    @JsonKey(name: "card_holder") required String cardHolder,
    @JsonKey(name: "masked_pan") required String maskedPan,
    @JsonKey(name: "balance") required double balance,
    @JsonKey(name: "card_type") required String cardType,
    @JsonKey(name: "bank_name") required String bankName,
    @JsonKey(name: "bank_logo_id") required int bankLogoId,
  }) = _RealPayCard;

  bool get isHumo => cardType.toUpperCase().contains("HUMO");

  factory RealPayCard.fromJson(Map<String, dynamic> json) =>
      _$RealPayCardFromJson(json);
}
