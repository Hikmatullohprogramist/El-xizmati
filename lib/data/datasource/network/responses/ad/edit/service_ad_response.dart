import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/edit/ad_address_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/edit/ad_payment_type_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/edit/ad_photo_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/address/user_address_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/category/category_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/image/uploadable_file.dart';

import '../../../../../../domain/models/category/category.dart';

part 'service_ad_response.freezed.dart';
part 'service_ad_response.g.dart';

ServiceAdRootResponse serviceAdResponseFromJson(String str) =>
    ServiceAdRootResponse.fromJson(json.decode(str));

String serviceAdResponseToJson(ServiceAdRootResponse data) =>
    json.encode(data.toJson());

@freezed
class ServiceAdRootResponse with _$ServiceAdRootResponse {
  const factory ServiceAdRootResponse({
    @JsonKey(name: "error") required dynamic error,
    @JsonKey(name: "message") required dynamic message,
    @JsonKey(name: "timestamp") required String timestamp,
    @JsonKey(name: "status") required int status,
    @JsonKey(name: "path") required dynamic path,
    @JsonKey(name: "data") required ServiceAdResponse data,
    @JsonKey(name: "response") required dynamic response,
  }) = _ServiceAdRootResponse;

  factory ServiceAdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceAdRootResponseFromJson(json);
}

@freezed
class ServiceAdResponse with _$ServiceAdResponse {
  const factory ServiceAdResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") required String? name,
    @JsonKey(name: "ad_type") required String? adType,
    @JsonKey(name: "category_id") required int? categoryId,
    @JsonKey(name: "category_name") required String? categoryName,
    @JsonKey(name: "sub_category_id") required int? subCategoryId,
    @JsonKey(name: "sub_category_name") required String? subCategoryName,
    @JsonKey(name: "description") required String? description,
    @JsonKey(name: "to_price") required int? toPrice,
    @JsonKey(name: "from_price") required int? fromPrice,
    @JsonKey(name: "currency_id") required int? currencyId,
    @JsonKey(name: "currency_name") required String? currencyName,
    @JsonKey(name: "is_contract") required bool? isContract,
    @JsonKey(name: "route_type") required String? routeType,
    @JsonKey(name: "address_id") required int? addressId,
    @JsonKey(name: "address_name") required String? addressName,
    @JsonKey(name: "email") required String? email,
    @JsonKey(name: "contact_name") required String? contactName,
    @JsonKey(name: "phone_number") required String? phoneNumber,
    @JsonKey(name: "is_auto_renew") required bool? isAutoRenew,
    @JsonKey(name: "video") required String? video,
    @JsonKey(name: "show_social") required bool? showSocial,
    @JsonKey(name: "photos") required List<AdPhotoResponse>? photos,
    @JsonKey(name: "payment_types")
    required List<AdPaymentTypeResponse>? paymentTypes,
    @JsonKey(name: "service_deliveries")
    required List<AdAddressResponse>? serviceDeliveries,
  }) = _ServiceAdResponse;

  const ServiceAdResponse._();

  factory ServiceAdResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceAdResponseFromJson(json);

  CategoryResponse? getCategory() {
    return categoryId == null
        ? null
        : CategoryResponse(id: categoryId!, name: categoryName);
  }

  Category? getSubCategory() {
    return subCategoryId == null
        ? null
        : Category(id: subCategoryId!, name: subCategoryName ?? "");
  }

  List<UploadableFile> getPhotos() {
    return photos
            ?.map((e) => e.image)
            .toSet()
            .map((e) => UploadableFile(id: e))
            .toList() ??
        [];
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

  UserAddressResponse? getUserAddress() {
    return addressId == null
        ? null
        : UserAddressResponse(id: addressId!, name: addressName);
  }

  List<District> getServiceDistricts() {
    return serviceDeliveries
            ?.map((e) => District(id: e.id, regionId: 0, name: e.name ?? ""))
            .toList() ??
        [];
  }
}
