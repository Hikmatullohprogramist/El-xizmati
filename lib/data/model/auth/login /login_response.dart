import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';

part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    Data? data,
    dynamic response,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    String? token,
    int? projectId,
    User? user,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    dynamic pinfl,
    String? authSource,
    String? gender,
    dynamic homeName,
    String? eimzoAllowToLogin,
    String? locale,
    dynamic type,
    dynamic orgId,
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
