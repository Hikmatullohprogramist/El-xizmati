import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_information_response.freezed.dart';

part 'user_information_response.g.dart';

@freezed
class UserInformationRootResponse with _$UserInformationRootResponse {
  const factory UserInformationRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
   required UserInformationResponse data,
    dynamic response,
  }) = _UserInformationRootResponse;

  factory UserInformationRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInformationRootResponseFromJson(json);
}

@freezed
class UserInformationResponse with _$UserInformationResponse {
  const factory UserInformationResponse({
    int? id,
    dynamic photo,
    String? username,
    dynamic districtId,
    dynamic fullName,
    dynamic regionId,
    dynamic postName,
    dynamic email,
    String? gender,
    dynamic telegramId,
    dynamic messageType,
    dynamic pinfl,
    dynamic tin,
    dynamic mahallaId,
    dynamic homeName,
    dynamic passportNumber,
    dynamic passportSerial,
    bool? isRegistered,
    dynamic birthDate,
    String? typeActivity,
    String? mobilePhone,
    List<Active>? actives,
    List<dynamic>? socials,
    UserDo? userDo,
  }) = _UserInformationResponse;

  factory UserInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInformationResponseFromJson(json);
}

@freezed
class Active with _$Active {
  const factory Active({
    int? id,
    String? token,
    String? lastActivityAt,
    String? lastLoginAt,
    String? userAgent,
    int? userId,
    String? lastIpAddress,
  }) = _Active;

  factory Active.fromJson(Map<String, dynamic> json) => _$ActiveFromJson(json);
}

@freezed
class UserDo with _$UserDo {
  const factory UserDo({
    int? id,
    dynamic pinfl,
  }) = _UserDo;

  factory UserDo.fromJson(Map<String, dynamic> json) => _$UserDoFromJson(json);
}
