// To parse this JSON data, do
//
//     final byPassportResponse = byPassportResponseFromJson(jsonString);

import 'dart:convert';

ValidateBioDocResponse validateBioDocResponseFromJson(String str) =>
    ValidateBioDocResponse.fromJson(json.decode(str));

String validateBioDocResponseToJson(ValidateBioDocResponse data) =>
    json.encode(data.toJson());

class ValidateBioDocResponse {
  dynamic error;
  dynamic message;
  String timestamp;
  int status;
  dynamic path;
  Data data;
  dynamic response;

  ValidateBioDocResponse({
    required this.error,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.path,
    required this.data,
    required this.response,
  });

  factory ValidateBioDocResponse.fromJson(Map<String, dynamic> json) =>
      ValidateBioDocResponse(
        error: json["error"],
        message: json["message"],
        timestamp: json["timestamp"],
        status: json["status"],
        path: json["path"],
        data: Data.fromJson(json["data"]),
        response: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "timestamp": timestamp,
        "status": status,
        "path": path,
        "data": data.toJson(),
        "response": response,
      };
}

class Data {
  String secretKey;
  String fullName;

  Data({
    required this.secretKey,
    required this.fullName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        secretKey: json["secret_key"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "secret_key": secretKey,
        "full_name": fullName,
      };
}
