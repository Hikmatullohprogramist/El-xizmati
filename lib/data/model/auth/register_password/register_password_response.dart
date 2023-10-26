import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_password_response.freezed.dart';

part 'register_password_response.g.dart';

@freezed
class RegisterPasswordRootResponse with _$RegisterPasswordRootResponse {
  const factory RegisterPasswordRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    RegisterPasswordResponse? data,
    dynamic response,
  }) = _RegisterPasswordRootResponse;

  factory RegisterPasswordRootResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterPasswordRootResponseFromJson(json);
}

@freezed
class RegisterPasswordResponse with _$RegisterPasswordResponse {
  const factory RegisterPasswordResponse({
    Password? password,
    IsPassword? updateUser,
    IsPassword? isPassword,
  }) = _RegisterPasswordResponse;

  factory RegisterPasswordResponse.fromJson(Map<String, dynamic> json) => _$RegisterPasswordResponseFromJson(json);
}

@freezed
class IsPassword with _$IsPassword {
  const factory IsPassword() = _IsPassword;

  factory IsPassword.fromJson(Map<String, dynamic> json) =>
      _$IsPasswordFromJson(json);
}

@freezed
class Password with _$Password {
  const factory Password({
    bool? newPassword,
    int? username,
  }) = _Password;

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);
}
