import 'package:freezed_annotation/freezed_annotation.dart';

part 'real_pay_merchant_token_response.freezed.dart';
part 'real_pay_merchant_token_response.g.dart';

@freezed
class RealPayMerchantTokenRootResponse with _$RealPayMerchantTokenRootResponse {
  const factory RealPayMerchantTokenRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required RealPayMerchantToken data,
    dynamic response,
  }) = _RealPayMerchantTokenRootResponse;

  factory RealPayMerchantTokenRootResponse.fromJson(
          Map<String, dynamic> json) =>
      _$RealPayMerchantTokenRootResponseFromJson(json);
}

@freezed
class RealPayMerchantToken with _$RealPayMerchantToken {
  const factory RealPayMerchantToken({
    @JsonKey(name: "merchant_token") required String merchantToken,
    @JsonKey(name: "token_type") required String tokenType,
  }) = _RealPayMerchantToken;

  factory RealPayMerchantToken.fromJson(Map<String, dynamic> json) =>
      _$RealPayMerchantTokenFromJson(json);
}
