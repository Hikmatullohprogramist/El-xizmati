import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_response.freezed.dart';
part 'verification_response.g.dart';

@freezed
class VerificationResponse with _$VerificationResponse {
  const factory VerificationResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _VerificationResponse;

  factory VerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$VerificationResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    required VerificationData data,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class VerificationData with _$VerificationData {
  const factory VerificationData({
    String? token,
    int? projectId,
    User? user,
  }) = _VerificationData;

  factory VerificationData.fromJson(Map<String, dynamic> json) =>
      _$VerificationDataFromJson(json);
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
