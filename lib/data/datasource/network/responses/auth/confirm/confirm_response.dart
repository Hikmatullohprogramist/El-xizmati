import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_response.freezed.dart';
part 'confirm_response.g.dart';

@freezed
class ConfirmRootResponse with _$ConfirmRootResponse {
  const factory ConfirmRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required ConfirmResponse data,
    dynamic response,
  }) = _ConfirmRootResponse;

  factory ConfirmRootResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmRootResponseFromJson(json);
}

@freezed
class ConfirmResponse with _$ConfirmResponse {
  const factory ConfirmResponse({
    String? token,
    int? projectId,
    User? user,
  }) = _ConfirmResponse;

  factory ConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmResponseFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    dynamic pinfl,
    String? ipaddress,
    String? authSource,
    String? gender,
    dynamic homeName,
    String? eimzoAllowToLogin,
    String? locale,
    dynamic type,
    dynamic orgId,
    bool? hasOtpSecret,
    int? updateId,
    dynamic orgType,
    dynamic messageType,
    List<String>? permissions,
    dynamic postName,
    dynamic tin,
    dynamic theme,
    int? id,
    int? state,
    dynamic email,
    dynamic passportNumber,
    dynamic passportSerial,
    bool? isPassword,
    dynamic level,
    dynamic photo,
    dynamic fullName,
    dynamic otpSecretDate,
    dynamic birthDate,
    dynamic telegramId,
    dynamic sourceUpdateId,
    dynamic registeredWithEimzo,
    dynamic areaId,
    dynamic apartmentName,
    dynamic districtId,
    String? mobilePhone,
    String? typeActivity,
    bool? isRegistered,
    int? projectId,
    dynamic oblId,
    String? loggingLevel,
    String? username,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
