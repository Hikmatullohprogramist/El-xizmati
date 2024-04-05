import 'dart:convert';

AdCreationRootResponse adCreationResponseFromJson(String str) =>
    AdCreationRootResponse.fromJson(json.decode(str));

String adCreationResponseToJson(AdCreationRootResponse data) =>
    json.encode(data.toJson());

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
  AdCreationResponse ad;

  Data({required this.ad});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(ad: AdCreationResponse.fromJson(json["insert_ad"]));

  Map<String, dynamic> toJson() => {"insert_ad": ad.toJson()};
}

class AdCreationResponse {
  int id;

  AdCreationResponse({required this.id});

  factory AdCreationResponse.fromJson(Map<String, dynamic> json) =>
      AdCreationResponse(id: json["id"]);

  Map<String, dynamic> toJson() => {"id": id};
}
