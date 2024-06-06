import 'package:freezed_annotation/freezed_annotation.dart';

part 'eds_sign_in_response.freezed.dart';
part 'eds_sign_in_response.g.dart';

@freezed
class EdsSignInRootResponse with _$EdsSignInRootResponse {
  const factory EdsSignInRootResponse({
    String? token,
    int? projectId,
    EdsUserResponse? user,
  }) = _EdsSignInRootResponse;

  factory EdsSignInRootResponse.fromJson(Map<String, dynamic> json) =>
      _$EdsSignInRootResponseFromJson(json);
}

@freezed
class EdsUserResponse with _$EdsUserResponse {
  const factory EdsUserResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "pinfl") int? pinfl,
    @JsonKey(name: "gender") String? gender,
    @JsonKey(name: "homeName") String? homeName,
    @JsonKey(name: "messageType") String? messageType,
    @JsonKey(name: "state") int? state,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "passportNumber") String? passportNumber,
    @JsonKey(name: "passportSerial") String? passportSerial,
    @JsonKey(name: "isPassword") bool? isPassword,
    @JsonKey(name: "photo") String? photo,
    @JsonKey(name: "fullName") String? fullName,
    @JsonKey(name: "birthDate") String? birthDate,
    @JsonKey(name: "areaId") int? areaId,
    @JsonKey(name: "oblId") int? oblId,
    @JsonKey(name: "districtId") int? districtId,
    @JsonKey(name: "apartmentName") String? apartmentName,
    @JsonKey(name: "mobilePhone") String? mobilePhone,
    @JsonKey(name: "isRegistered") bool? isRegistered,

    // @JsonKey(name: "ipaddress") required String ipaddress,
    // @JsonKey(name: "authSource") required String authSource,

    // @JsonKey(name: "eimzoAllowToLogin") String? eimzoAllowToLogin,
    // @JsonKey(name: "locale") String? locale,
    // @JsonKey(name: "type") dynamic type,
    // @JsonKey(name: "orgId") dynamic orgId,
    // @JsonKey(name: "hasOtpSecret") bool hasOtpSecret,
    // @JsonKey(name: "updateId") int updateId,
    // @JsonKey(name: "orgType") dynamic orgType,

    // @JsonKey(name: "permissions") List<String> permissions,
    // @JsonKey(name: "postName") dynamic postName,
    // @JsonKey(name: "theme") dynamic theme,

    // @JsonKey(name: "level") dynamic level,

    // @JsonKey(name: "otpSecretDate") dynamic otpSecretDate,

    // @JsonKey(name: "sellerInfo") bool sellerInfo,
    // @JsonKey(name: "telegramId") dynamic telegramId,
    // @JsonKey(name: "sourceUpdateId") dynamic sourceUpdateId,
    // @JsonKey(name: "registeredWithEimzo") dynamic registeredWithEimzo,

    // @JsonKey(name: "hasBind") bool? hasBind,
    // @JsonKey(name: "typeActivity") String? typeActivity,
    // @JsonKey(name: "projectId") int projectId,
    // @JsonKey(name: "loggingLevel") String loggingLevel,
    // @JsonKey(name: "username") String? username,
  }) = _EdsUserResponse;

  factory EdsUserResponse.fromJson(Map<String, dynamic> json) =>
      _$EdsUserResponseFromJson(json);
}
