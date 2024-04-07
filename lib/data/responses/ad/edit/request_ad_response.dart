import 'dart:convert';

import 'package:onlinebozor/data/responses/ad/edit/ad_field_response.dart';

import '../../../../domain/models/district/district.dart';
import '../../../../domain/models/image/uploadable_file.dart';
import '../../address/user_address_response.dart';
import '../../category/category/category_response.dart';
import '../../currencies/currency_response.dart';
import '../../payment_type/payment_type_response.dart';

RequestAdRootResponse requestAdResultResponseFromJson(String str) =>
    RequestAdRootResponse.fromJson(json.decode(str));

class RequestAdRootResponse {
  dynamic error;
  dynamic message;
  String timestamp;
  int status;
  dynamic path;
  RequestAdResponse data;
  dynamic response;

  RequestAdRootResponse({
    required this.error,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.path,
    required this.data,
    required this.response,
  });

  factory RequestAdRootResponse.fromJson(Map<String, dynamic> json) =>
      RequestAdRootResponse(
        error: json["error"],
        message: json["message"],
        timestamp: json["timestamp"],
        status: json["status"],
        path: json["path"],
        data: RequestAdResponse.fromJson(json["data"]),
        response: json["response"],
      );
}

class RequestAdResponse {
  int id;
  String name;
  String adType;
  int? categoryId;
  String? categoryName;
  String? description;
  int? toPrice;
  int? fromPrice;
  int? currencyId;
  String? currencyName;
  bool? isContract;
  String routeType;
  int? addressId;
  String? addressName;
  String? email;
  String? contactName;
  String? phoneNumber;
  bool? isAutoRenew;
  String? video;
  List<AdPhotoResponse>? photos;
  bool? showSocial;
  List<AdPaymentTypeResponse>? paymentTypes;
  List<AdAddressResponse>? deliveries;

  RequestAdResponse({
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
    required this.deliveries,
  });

  factory RequestAdResponse.fromJson(Map<String, dynamic> json) =>
      RequestAdResponse(
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
            json["photos"].map((x) => AdPhotoResponse.fromJson(x))),
        showSocial: json["show_social"],
        paymentTypes: List<AdPaymentTypeResponse>.from(json["payment_types"]
            .map((x) => AdPaymentTypeResponse.fromJson(x))),
        deliveries: List<AdAddressResponse>.from(
            json["deliveries"].map((x) => AdAddressResponse.fromJson(x))),
      );

  CategoryResponse? getCategory() {
    return categoryId == null
        ? null
        : CategoryResponse(id: categoryId!, name: categoryName);
  }

  // CategoryResponse? getSubCategory() {
  //   return subCategoryId == null
  //       ? null
  //       : CategoryResponse(id: subCategoryId!, name: subCategoryName);
  // }

  List<UploadableFile> getPhotos() {
    return photos
            ?.map((e) => e.image)
            .toSet()
            .map((e) => UploadableFile(id: e))
            .toList() ??
        [];
  }

  CurrencyResponse? getCurrency() {
    return currencyId == null
        ? null
        : CurrencyResponse(id: "$currencyId", name: currencyName);
  }

  List<PaymentTypeResponse> getPaymentTypes() {
    return paymentTypes
            ?.map((e) => PaymentTypeResponse(id: e.id, name: e.name))
            .toList() ??
        [];
  }

  bool getIsBusiness() {
    return routeType.toUpperCase().contains("BUSINESS");
  }

  UserAddressResponse? getUserAddress() {
    return addressId == null
        ? null
        : UserAddressResponse(id: addressId!, name: addressName);
  }

  List<District> getRequestDistricts() {
    return deliveries
            ?.map((e) => District(id: e.id, regionId: 0, name: e.name ?? ""))
            .toList() ??
        [];
  }
}
