import 'dart:convert';

AdCreationRootResponse adCreationResponseFromJson(String str) =>
    AdCreationRootResponse.fromJson(json.decode(str));

class AdCreationRootResponse {
  dynamic error;
  dynamic message;
  String timestamp;
  int status;
  dynamic path;
  Data data;
  dynamic response;

  AdCreationRootResponse({
    required this.error,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.path,
    required this.data,
    required this.response,
  });

  factory AdCreationRootResponse.fromJson(Map<String, dynamic> json) =>
      AdCreationRootResponse(
        error: json["error"],
        message: json["message"],
        timestamp: json["timestamp"],
        status: json["status"],
        path: json["path"],
        data: Data.fromJson(json["data"]),
        response: json["response"],
      );
}

class Data {
  AdCreationResponse? insertedAd;
  AdCreationResponse? updatedAd;

  Data({
    required this.insertedAd,
    required this.updatedAd,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        insertedAd: AdCreationResponse.fromJson(json["insert_ad"]),
        updatedAd: AdCreationResponse.fromJson(json["update_ad"]),
      );
}

class AdCreationResponse {
  int id;

  AdCreationResponse({required this.id});

  factory AdCreationResponse.fromJson(Map<String, dynamic> json) =>
      AdCreationResponse(id: json["id"]);

  Map<String, dynamic> toJson() => {"id": id};
}
