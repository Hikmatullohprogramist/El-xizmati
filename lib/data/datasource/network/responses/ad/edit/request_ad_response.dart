import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/edit/ad_address_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/edit/ad_payment_type_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/edit/ad_photo_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';

import '../../../../../../domain/models/category/category.dart';

part 'request_ad_response.freezed.dart';
part 'request_ad_response.g.dart';

RequestAdRootResponse adCreationResultRootResponseFromJson(String str) =>
    RequestAdRootResponse.fromJson(json.decode(str));

String adCreationResultRootResponseToJson(RequestAdRootResponse data) =>
    json.encode(data.toJson());

@freezed
class RequestAdRootResponse with _$RequestAdRootResponse {
  const factory RequestAdRootResponse({
    required dynamic error,
    required dynamic message,
    required String timestamp,
    required int status,
    required dynamic path,
    required RequestAdResponse data,
    required dynamic response,
  }) = _AdCreationResultRootResponse;

  factory RequestAdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestAdRootResponseFromJson(json);
}

@freezed
class RequestAdResponse with _$RequestAdResponse {
  const factory RequestAdResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") required String? name,
    @JsonKey(name: "ad_type") required String? adType,
    @JsonKey(name: "category_id") required int? categoryId,
    @JsonKey(name: "category_name") required String? categoryName,
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
    @JsonKey(name: "deliveries") required List<AdAddressResponse>? deliveries,
  }) = _RequestAdResponse;

  const RequestAdResponse._();

  factory RequestAdResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestAdResponseFromJson(json);

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

  List<District> getRequestDistricts() {
    return deliveries
            ?.map((e) => District(id: e.id, regionId: 0, name: e.name ?? ""))
            .toList() ??
        [];
  }
}
