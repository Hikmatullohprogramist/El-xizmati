import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_otp_confirm_response.freezed.dart';
part 'auth_otp_confirm_response.g.dart';

@freezed
class AuthOtpConfirmRootResponse with _$AuthOtpConfirmRootResponse {
  const factory AuthOtpConfirmRootResponse({
    AuthOtpConfirmResponse? data,
    dynamic error,
  }) = _AuthOtpConfirmRootResponse;

  factory AuthOtpConfirmRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthOtpConfirmRootResponseFromJson(json);
}


@freezed
class AuthOtpConfirmResponse with _$AuthOtpConfirmResponse {
  const factory AuthOtpConfirmResponse({
    String? phone_number,
    bool?  is_created,
    TokensResponse? tokens,
  }) = _AuthOtpConfirmResponse;

  factory AuthOtpConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthOtpConfirmResponseFromJson(json);
}


@freezed
class TokensResponse with _$TokensResponse {
  const factory TokensResponse({
    String? access,
    String? refresh,
  }) = _TokensResponse;

  factory TokensResponse.fromJson(Map<String, dynamic> json) =>
      _$TokensResponseFromJson(json);
}
