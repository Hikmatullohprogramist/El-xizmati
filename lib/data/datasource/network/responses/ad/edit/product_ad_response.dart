import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/edit/ad_address_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/edit/ad_payment_type_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/edit/ad_photo_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/unit/unit_response.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';

part 'product_ad_response.freezed.dart';
part 'product_ad_response.g.dart';

ProductAdRootResponse productAdResponseFromJson(String str) =>
    ProductAdRootResponse.fromJson(json.decode(str));

String productAdResponseToJson(ProductAdRootResponse data) =>
    json.encode(data.toJson());

@freezed
class ProductAdRootResponse with _$ProductAdRootResponse {
  const factory ProductAdRootResponse({
    @JsonKey(name: "error") required dynamic error,
    @JsonKey(name: "message") required dynamic message,
    @JsonKey(name: "timestamp") required String timestamp,
    @JsonKey(name: "status") required int status,
    @JsonKey(name: "path") required dynamic path,
    @JsonKey(name: "data") required ProductAdResponse data,
    @JsonKey(name: "response") required dynamic response,
  }) = _ProductAdRootResponse;

  factory ProductAdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductAdRootResponseFromJson(json);
}

@freezed
class ProductAdResponse with _$ProductAdResponse {
  const factory ProductAdResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "amount") required int? warehouseCount,
    @JsonKey(name: "name") required String? name,
    @JsonKey(name: "ad_type") required String? adType,
    @JsonKey(name: "category_id") required int? categoryId,
    @JsonKey(name: "category_name") required String? categoryName,
    @JsonKey(name: "description") required String? description,
    @JsonKey(name: "price") required int? price,
    @JsonKey(name: "currency_id") required int? currencyId,
    @JsonKey(name: "currency_name") required String? currencyName,
    @JsonKey(name: "is_contract") required bool? isContract,
    @JsonKey(name: "route_type") required String? routeType,
    @JsonKey(name: "property_status") required String? propertyStatus,
    @JsonKey(name: "address_id") required int? addressId,
    @JsonKey(name: "address_name") required String? addressName,
    @JsonKey(name: "email") required String? email,
    @JsonKey(name: "contact_name") required String? contactName,
    @JsonKey(name: "phone_number") required String? phoneNumber,
    @JsonKey(name: "is_auto_renew") required bool? isAutoRenew,
    @JsonKey(name: "video") required String? video,
    @JsonKey(name: "other_name") required String? otherName,
    @JsonKey(name: "other_category_id") required int? otherCategoryId,
    @JsonKey(name: "other_category_name") required String? otherCategoryName,
    @JsonKey(name: "other_description") required String? otherDescription,
    @JsonKey(name: "other_route_type") required String? otherRouteType,
    @JsonKey(name: "other_property_status")
    required String? otherPropertyStatus,
    @JsonKey(name: "show_social") required bool? showSocial,
    @JsonKey(name: "unit_id") required int? unitId,
    @JsonKey(name: "unit_name") required String? unitName,
    @JsonKey(name: "free_delivery_enabled") required bool? freeDeliveryEnabled,
    @JsonKey(name: "paid_delivery_enabled") required bool? paidDeliveryEnabled,
    @JsonKey(name: "pickup_enabled") required bool? pickupEnabled,
    @JsonKey(name: "paid_delivery_price") required int? paidDeliveryPrice,
    @JsonKey(name: "paid_delivery_unit_id") required int? paidDeliveryUnitId,
    @JsonKey(name: "photos") required List<AdPhotoResponse>? photos,
    @JsonKey(name: "payment_types")
    required List<AdPaymentTypeResponse>? paymentTypes,
    @JsonKey(name: "pickup_warehouses")
    required List<AdAddressResponse>? pickupWarehouses,
    @JsonKey(name: "free_delivery_districts")
    required List<AdAddressResponse>? freeDeliveryDistricts,
    @JsonKey(name: "paid_delivery_districts")
    required List<AdAddressResponse>? paidDeliveryDistricts,
  }) = _ProductAdResponse;

  factory ProductAdResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductAdResponseFromJson(json);

  const ProductAdResponse._();

  Category? getCategory() {
    return categoryId == null
        ? null
        : Category(id: categoryId!, name: categoryName ?? "");
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

  Currency? getCurrency() {
    return currencyId == null
        ? null
        : Currency(id: "$currencyId", name: currencyName);
  }

  List<PaymentTypeResponse> getPaymentTypes() {
    return paymentTypes
            ?.map((e) => PaymentTypeResponse(id: e.id, name: e.name))
            .toList() ??
        [];
  }

  bool getIsBusiness() {
    return routeType?.toUpperCase().contains("BUSINESS") == true;
  }

  bool getIsNew() {
    return propertyStatus?.toUpperCase().contains("NEW") == true ||
        propertyStatus?.toUpperCase().contains("FRESH") == true;
  }

  bool getIsOtherNew() {
    return otherPropertyStatus?.toUpperCase().contains("NEW") == true ||
        otherPropertyStatus?.toUpperCase().contains("FRESH") == true;
  }

  Category? getOtherCategory() {
    return otherCategoryId == null
        ? null
        : Category(id: otherCategoryId!, name: otherCategoryName ?? "");
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
