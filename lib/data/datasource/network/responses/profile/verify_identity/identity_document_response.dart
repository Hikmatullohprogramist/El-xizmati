import 'dart:convert';

IdentityDocumentRootResponse identityDocumentRootResponseFromJson(String str) =>
    IdentityDocumentRootResponse.fromJson(json.decode(str));

class IdentityDocumentRootResponse {
  dynamic error;
  dynamic message;
  String timestamp;
  int status;
  dynamic path;
  IdentityDocumentInfoResponse data;
  dynamic response;

  IdentityDocumentRootResponse({
    required this.error,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.path,
    required this.data,
    required this.response,
  });

  factory IdentityDocumentRootResponse.fromJson(Map<String, dynamic> json) =>
      IdentityDocumentRootResponse(
        error: json["error"],
        message: json["message"],
        timestamp: json["timestamp"],
        status: json["status"],
        path: json["path"],
        data: IdentityDocumentInfoResponse.fromJson(json["data"]),
        response: json["response"],
      );
}

class IdentityDocumentInfoResponse {
  IdentityDocumentResponse? passportInfo;
  String? status;
  String? secretKey;

  IdentityDocumentInfoResponse({
    required this.passportInfo,
    required this.status,
    required this.secretKey,
  });

  factory IdentityDocumentInfoResponse.fromJson(Map<String, dynamic> json) =>
      IdentityDocumentInfoResponse(
        passportInfo: IdentityDocumentResponse.fromJson(json["passportInfo"]),
        status: json["status"],
        secretKey: json["secret_key"],
      );
}

class IdentityDocumentResponse {
  int? pinfl;
  String? number;
  String? fullName;
  String? gender;
  String? series;
  String? birthDate;
  int? tin;
  int? regionId;
  int? districtId;

  IdentityDocumentResponse({
    required this.pinfl,
    required this.number,
    required this.fullName,
    required this.gender,
    required this.series,
    required this.birthDate,
    required this.tin,
    required this.regionId,
    required this.districtId,
  });

  factory IdentityDocumentResponse.fromJson(Map<String, dynamic> json) =>
      IdentityDocumentResponse(
        pinfl: json["pinfl"],
        number: json["number"],
        fullName: json["full_name"],
        gender: json["gender"],
        series: json["series"],
        birthDate: json["birth_date"],
        tin: json["tin"],
        regionId: json["region_id"],
        districtId: json["district_id"],
      );
}
