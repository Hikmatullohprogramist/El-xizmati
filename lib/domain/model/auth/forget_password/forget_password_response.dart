import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_response.freezed.dart';

part 'forget_password_response.g.dart';

@freezed
class ForgetPasswordRootResponse with _$ForgetPasswordRootResponse {
  const factory ForgetPasswordRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    ForgetPasswordResponse? data,
    dynamic response,
  }) = _ForgetPasswordRootResponse;

  factory ForgetPasswordRootResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRootResponseFromJson(json);
}

@freezed
class ForgetPasswordResponse with _$ForgetPasswordResponse {
  const factory ForgetPasswordResponse({
    Valid? valid,
    String? sessionToken,
  }) = _ForgetPasswordResponse;

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);
}

@freezed
class Valid with _$Valid {
  const factory Valid() = _Valid;

  factory Valid.fromJson(Map<String, dynamic> json) => _$ValidFromJson(json);
}
