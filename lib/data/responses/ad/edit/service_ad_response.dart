// To parse this JSON data, do
//
//     final serviceAdResultResponse = serviceAdResultResponseFromJson(jsonString);

import 'dart:convert';

import 'package:onlinebozor/data/responses/ad/edit/ad_field_response.dart';

ServiceAdRootResponse serviceAdResultResponseFromJson(String str) =>
    ServiceAdRootResponse.fromJson(json.decode(str));

String serviceAdResultResponseToJson(ServiceAdRootResponse data) =>
    json.encode(data.toJson());

class ServiceAdRootResponse {
  dynamic error;
  dynamic message;
  String timestamp;
  int status;
  dynamic path;
  ServiceAdResponse data;
  dynamic response;

  ServiceAdRootResponse({
    required this.error,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.path,
    required this.data,
    required this.response,
  });

  factory ServiceAdRootResponse.fromJson(Map<String, dynamic> json) =>
      ServiceAdRootResponse(
        error: json["error"],
        message: json["message"],
        timestamp: json["timestamp"],
        status: json["status"],
        path: json["path"],
        data: ServiceAdResponse.fromJson(json["data"]),
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

class ServiceAdResponse {
  int id;
  String name;
  String adType;
  int categoryId;
  String categoryName;
  String description;
  int toPrice;
  int fromPrice;
  int currencyId;
  String currencyName;
  bool isContract;
  String routeType;
  int addressId;
  String addressName;
  String email;
  String contactName;
  String phoneNumber;
  bool isAutoRenew;
  String video;
  List<AdPhotoResponse> photos;
  bool showSocial;
  List<AdPaymentTypeResponse> paymentTypes;
  List<AdAddressResponse> serviceDeliveries;

  ServiceAdResponse({
    required this.id,
    required this.name,
    required this.adType,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.toPrice,
    required this.fromPrice,
    required this.currencyId,
    required this.currencyName,
    required this.isContract,
    required this.routeType,
    required this.addressId,
    required this.addressName,
    required this.email,
    required this.contactName,
    required this.phoneNumber,
    required this.isAutoRenew,
    required this.video,
    required this.photos,
    required this.showSocial,
    required this.paymentTypes,
    required this.serviceDeliveries,
  });

  factory ServiceAdResponse.fromJson(Map<String, dynamic> json) => ServiceAdResponse(
        id: json["id"],
        name: json["name"],
        adType: json["ad_type"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        description: json["description"],
        toPrice: json["to_price"],
        fromPrice: json["from_price"],
        currencyId: json["currency_id"],
        currencyName: json["currency_name"],
        isContract: json["is_contract"],
        routeType: json["route_type"],
        addressId: json["address_id"],
        addressName: json["address_name"],
        email: json["email"],
        contactName: json["contact_name"],
        phoneNumber: json["phone_number"],
        isAutoRenew: json["is_auto_renew"],
        video: json["video"],
        photos: List<AdPhotoResponse>.from(
          json["photos"].map((x) => AdPhotoResponse.fromJson(x)),
        ),
        showSocial: json["show_social"],
        paymentTypes: List<AdPaymentTypeResponse>.from(
          json["payment_types"].map((x) => AdPaymentTypeResponse.fromJson(x)),
        ),
        serviceDeliveries: List<AdAddressResponse>.from(
          json["service_deliveries"].map((x) => AdAddressResponse.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ad_type": adType,
        "category_id": categoryId,
        "category_name": categoryName,
        "description": description,
        "to_price": toPrice,
        "from_price": fromPrice,
        "currency_id": currencyId,
        "currency_name": currencyName,
        "is_contract": isContract,
        "route_type": routeType,
        "address_id": addressId,
        "address_name": addressName,
        "email": email,
        "contact_name": contactName,
        "phone_number": phoneNumber,
        "is_auto_renew": isAutoRenew,
        "video": video,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "show_social": showSocial,
        "payment_types":
            List<dynamic>.from(paymentTypes.map((x) => x.toJson())),
        "service_deliveries":
            List<dynamic>.from(serviceDeliveries.map((x) => x.toJson())),
      };
}
