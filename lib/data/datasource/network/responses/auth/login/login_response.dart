import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginRootResponse with _$LoginRootResponse {
  const factory LoginRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required LoginResponse data,
    dynamic response,
  }) = _LoginRootResponse;

  factory LoginRootResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginRootResponseFromJson(json);
}

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    String? token,
    int? projectId,
    LoginUser? user,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class LoginUser with _$LoginUser {
  const factory LoginUser({
    required int id,
    dynamic pinfl,
    dynamic tin,
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
    dynamic theme,
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
    @JsonKey(name: "oblId") dynamic regionId,
    @JsonKey(name: "areaId") dynamic districtId,
    @JsonKey(name: "districtId") dynamic neighborhoodId,
    dynamic apartmentName,
    String? mobilePhone,
    String? typeActivity,
    bool? isRegistered,
    int? projectId,
    String? loggingLevel,
    // String? username,
  }) = _LoginUser;

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);
}
