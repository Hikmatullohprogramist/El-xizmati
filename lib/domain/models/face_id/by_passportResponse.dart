// To parse this JSON data, do
//
//     final byPassportResponse = byPassportResponseFromJson(jsonString);

import 'dart:convert';

ByPassportResponse byPassportResponseFromJson(String str) => ByPassportResponse.fromJson(json.decode(str));

String byPassportResponseToJson(ByPassportResponse data) => json.encode(data.toJson());

class ByPassportResponse {
  dynamic error;
  dynamic message;
  String timestamp;
  int status;
  dynamic path;
  Data data;
  dynamic response;

  ByPassportResponse({
    required this.error,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.path,
    required this.data,
    required this.response,
  });

  factory ByPassportResponse.fromJson(Map<String, dynamic> json) => ByPassportResponse(
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
