import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_otp_confirm_response.freezed.dart';
part 'register_otp_confirm_response.g.dart';

@freezed
class RegisterOtpConfirmResponse with _$RegisterOtpConfirmResponse {
  const factory RegisterOtpConfirmResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _RegisterOtpConfirmResponse;

  factory RegisterOtpConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterOtpConfirmResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: "secret_key") required String secretKey,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
