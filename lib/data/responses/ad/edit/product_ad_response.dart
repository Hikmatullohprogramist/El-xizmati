import 'dart:convert';

import 'package:onlinebozor/data/responses/ad/edit/ad_field_response.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';

import '../../../../domain/models/district/district.dart';

ProductAdRootResponse productAdResultResponseFromJson(String str) =>
    ProductAdRootResponse.fromJson(json.decode(str));

class ProductAdRootResponse {
  dynamic error;
  dynamic message;
  String timestamp;
  int status;
  dynamic path;
  ProductAdResponse data;
  dynamic response;

  ProductAdRootResponse({
    required this.error,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.path,
    required this.data,
    required this.response,
  });

  factory ProductAdRootResponse.fromJson(Map<String, dynamic> json) =>
      ProductAdRootResponse(
        error: json["error"],
        message: json["message"],
        timestamp: json["timestamp"],
        status: json["status"],
        path: json["path"],
        data: ProductAdResponse.fromJson(json["data"]),
        response: json["response"],
      );
}

class ProductAdResponse {
  int id;
  String name;
  String adType;
  int categoryId;
  String categoryName;
  String? description;
  int? price;
  int? currencyId;
  String? currencyName;
  bool isContract;
  String routeType;
  String propertyStatus;
  int? addressId;
  String? addressName;
  String? email;
  String? contactName;
  String? phoneNumber;
  bool? isAutoRenew;
  String? video;
  List<AdPhotoResponse>? photos;
  String? otherName;
  int? otherCategoryId;
  String? otherCategoryName;
  String? otherDescription;
  String? otherPropertyStatus;
  bool showSocial;
  int? unitId;
  String? unitName;
  int? warehouseCount;
  List<AdPaymentTypeResponse>? paymentTypes;
  bool? pickupEnabled;
  List<AdAddressResponse>? pickupWarehouses;
  bool? freeDeliveryEnabled;
  int? freeDeliveryMaxDays;
  List<AdAddressResponse>? freeDeliveryDistricts;
  bool? paidDeliveryEnabled;
  int? paidDeliveryMaxDays;
  int? paidDeliveryPrice;
  int? paidDeliveryUnitId;
  List<AdAddressResponse>? paidDeliveryDistricts;

  ProductAdResponse({
    required this.id,
    required this.name,
    required this.adType,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.price,
    required this.currencyId,
    required this.currencyName,
    required this.isContract,
    required this.routeType,
    required this.propertyStatus,
    required this.addressId,
    required this.addressName,
    required this.email,
    required this.contactName,
    required this.phoneNumber,
    required this.isAutoRenew,
    required this.video,
    required this.photos,
    required this.otherName,
    required this.otherCategoryId,
    required this.otherCategoryName,
    required this.otherDescription,
    required this.otherPropertyStatus,
    required this.showSocial,
    required this.unitId,
    required this.unitName,
    required this.warehouseCount,
    required this.paymentTypes,
    required this.pickupEnabled,
    required this.pickupWarehouses,
    required this.freeDeliveryEnabled,
    required this.freeDeliveryMaxDays,
    required this.freeDeliveryDistricts,
    required this.paidDeliveryEnabled,
    required this.paidDeliveryMaxDays,
    required this.paidDeliveryPrice,
    required this.paidDeliveryUnitId,
    required this.paidDeliveryDistricts,
  });

  factory ProductAdResponse.fromJson(Map<String, dynamic> json) =>
      ProductAdResponse(
        id: json["id"],
        name: json["name"],
        adType: json["ad_type"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        description: json["description"],
        price: json["price"],
        currencyId: json["currency_id"],
        currencyName: json["currency_name"],
        isContract: json["is_contract"],
        routeType: json["route_type"],
        propertyStatus: json["property_status"],
        addressId: json["address_id"],
        addressName: json["address_name"],
        email: json["email"],
        contactName: json["contact_name"],
        phoneNumber: json["phone_number"],
        isAutoRenew: json["is_auto_renew"],
        video: json["video"],
        photos: List<AdPhotoResponse>.from(
            json["photos"].map((x) => AdPhotoResponse.fromJson(x))),
        otherName: json["other_name"],
        otherCategoryId: json["other_category_id"],
        otherCategoryName: json["other_category_name"],
        otherDescription: json["other_description"],
        otherPropertyStatus: json["other_property_status"],
        showSocial: json["show_social"],
        unitId: json["unit_id"],
        unitName: json["unit_name"],
        warehouseCount: json["warehouse_count"],
        paymentTypes: List<AdPaymentTypeResponse>.from(json["payment_types"]
            .map((x) => AdPaymentTypeResponse.fromJson(x))),
        pickupEnabled: json["pickup_enabled"],
        pickupWarehouses: List<AdAddressResponse>.from(json["pickup_warehouses"]
            .map((x) => AdAddressResponse.fromJson(x))),
        freeDeliveryEnabled: json["free_delivery_enabled"],
        freeDeliveryMaxDays: json["free_delivery_max_days"],
        freeDeliveryDistricts: List<AdAddressResponse>.from(
            json["free_delivery_districts"]
                .map((x) => AdAddressResponse.fromJson(x))),
        paidDeliveryEnabled: json["paid_delivery_enabled"],
        paidDeliveryMaxDays: json["paid_delivery_max_days"],
        paidDeliveryPrice: json["paid_delivery_price"],
        paidDeliveryUnitId: json["paid_delivery_unit_id"],
        paidDeliveryDistricts: List<AdAddressResponse>.from(
            json["paid_delivery_districts"]
                .map((x) => AdAddressResponse.fromJson(x))),
      );

  CategoryResponse? getCategory() {
    return CategoryResponse(id: categoryId, name: categoryName);
  }

  List<UploadableFile> getPhotos() {
    return photos
        ?.map((e) => e.image)
        .toSet()
        .map((e) => UploadableFile(id: e))
        .toList() ??
        [];
  }

  UnitResponse? getUnit() {
    return unitId == null ? null : UnitResponse(id: unitId!, name: unitName);
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

  bool getIsNew() {
    return propertyStatus.toUpperCase().contains("FRESH");
  }

  bool getIsOtherNew() {
    return otherPropertyStatus?.toUpperCase().contains("FRESH") ?? false;
  }

  CategoryResponse? getOtherCategory() {
    return otherCategoryId == null
        ? null
        : CategoryResponse(id: otherCategoryId!, name: otherCategoryName);
  }

  UserAddressResponse? getUserAddress() {
    return addressId == null
        ? null
        : UserAddressResponse(id: addressId!, name: addressName);
  }

  List<UserAddressResponse> getWarehouses() {
    return pickupWarehouses
            ?.map((e) => UserAddressResponse(id: e.id, name: e.name))
            .toList() ??
        [];
  }

  List<District> getFreeDeliveryDistricts() {
    return freeDeliveryDistricts
            ?.map((e) => District(id: e.id, regionId: 0, name: e.name ?? ""))
            .toList() ??
        [];
  }

  List<District> getPaidDeliveryDistricts() {
    return paidDeliveryDistricts
            ?.map((e) => District(id: e.id, regionId: 0, name: e.name ?? ""))
            .toList() ??
        [];
  }
}
