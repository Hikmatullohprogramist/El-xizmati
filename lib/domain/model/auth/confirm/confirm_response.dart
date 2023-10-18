import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_response.freezed.dart';

part 'confirm_response.g.dart';

@freezed
class ConfirmResponse with _$ConfirmResponse {
  const factory ConfirmResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _ConfirmResponse;

  factory ConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    Password? password,
    IsPassword? updateUser,
    IsPassword? isPassword,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
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
