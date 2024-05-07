import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_ad_detail_response.freezed.dart';
part 'user_ad_detail_response.g.dart';

@freezed
class UserAdDetailRootResponse with _$UserAdDetailRootResponse {
  const factory UserAdDetailRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _UserAdDetailRootResponse;

  factory UserAdDetailRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: "results") required UserAdDetail userAdDetail,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class UserAdDetail with _$UserAdDetail {
  const factory UserAdDetail({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "sale_type") String? saleType,
    @JsonKey(name: "main_type_status") String? mainTypeStatus,
    @JsonKey(name: "category") UserAdDetailCategory? category,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "currency") String? currency,
    @JsonKey(name: "is_contract") bool? isContract,
    @JsonKey(name: "route_type") String? routeType,
    @JsonKey(name: "property_status") String? propertyStatus,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "phone_number") String? phoneNumber,
    @JsonKey(name: "is_auto_renew") bool? isAutoRenew,
    @JsonKey(name: "type_status") String? typeStatus,
    @JsonKey(name: "begin_date") String? beginDate,
    @JsonKey(name: "end_date") String? endDate,
    @JsonKey(name: "seller") UserAdDetailSeller? seller,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "other_name") String? otherName,
    @JsonKey(name: "other_category")
    UserAdDetailExchangeCategory? exchangeCategory,
    @JsonKey(name: "other_description") String? otherDescription,
    @JsonKey(name: "other_route_type") dynamic otherRouteType,
    @JsonKey(name: "other_property_status") dynamic otherPropertyStatus,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "show_social") dynamic showSocial,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "has_free_shipping") bool? hasFreeShipping,
    @JsonKey(name: "has_shipping") bool? hasShipping,
    @JsonKey(name: "has_warehouse") bool? hasWarehouse,
    @JsonKey(name: "shipping_price") int? shippingPrice,
    @JsonKey(name: "shipping_unit_id") dynamic shippingUnitId,
    @JsonKey(name: "view") int? viewCount,
    @JsonKey(name: "selected") int? favoriteCount,
    @JsonKey(name: "phone_view") int? phoneViewCount,
    @JsonKey(name: "message_number") int? smsViewCount,
    @JsonKey(name: "type_expire_date") dynamic typeExpireDate,
    @JsonKey(name: "unit_id") dynamic unitId,
    @JsonKey(name: "to_price") int? toPrice,
    @JsonKey(name: "from_price") int? fromPrice,
    @JsonKey(name: "address_id") int? addressId,
    @JsonKey(name: "video") dynamic video,
    @JsonKey(name: "params") List<dynamic>? params,
    @JsonKey(name: "social_medias") List<dynamic>? socialMedias,
    @JsonKey(name: "warehouses") List<dynamic>? warehouses,
    @JsonKey(name: "shippings") List<dynamic>? shippings,
    @JsonKey(name: "photos") List<UserAdDetailPhoto>? photos,
    @JsonKey(name: "payment_types") List<UserAdDetailPaymentType>? paymentTypes,
  }) = _UserAdDetail;

  factory UserAdDetail.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailFromJson(json);
}

@freezed
class UserAdDetailCategory with _$UserAdDetailCategory {
  const factory UserAdDetailCategory({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "is_sell") bool? isSell,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "key_word") String? keyWord,
  }) = _UserAdDetailCategory;

  factory UserAdDetailCategory.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailCategoryFromJson(json);
}

@freezed
class UserAdDetailPaymentType with _$UserAdDetailPaymentType {
  const factory UserAdDetailPaymentType({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") String? name,
  }) = _UserAdDetailPaymentType;

  factory UserAdDetailPaymentType.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailPaymentTypeFromJson(json);
}

@freezed
class UserAdDetailExchangeCategory with _$UserAdDetailExchangeCategory {
  const factory UserAdDetailExchangeCategory({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
  }) = _UserAdDetailExchangeCategory;

  factory UserAdDetailExchangeCategory.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailExchangeCategoryFromJson(json);
}

@freezed
class UserAdDetailPhoto with _$UserAdDetailPhoto {
  const factory UserAdDetailPhoto({
    @JsonKey(name: "image") required String image,
    @JsonKey(name: "is_main") bool? isMain,
  }) = _UserAdDetailPhoto;

  factory UserAdDetailPhoto.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailPhotoFromJson(json);
}

@freezed
class UserAdDetailSeller with _$UserAdDetailSeller {
  const factory UserAdDetailSeller({
    @JsonKey(name: "full_name") String? fullName,
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "last_login_at") String? lastLoginAt,
    @JsonKey(name: "photo") dynamic photo,
  }) = _UserAdDetailSeller;

  factory UserAdDetailSeller.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailSellerFromJson(json);
}
