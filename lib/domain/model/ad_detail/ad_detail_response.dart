import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_detail_response.freezed.dart';

part 'ad_detail_response.g.dart';

@freezed
class AdDetailResponse with _$AdDetailResponse {
  const factory AdDetailResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    Data? data,
    dynamic response,
  }) = _AdDetailResponse;

  factory AdDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    Results? results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Results with _$Results {
  const factory Results({
    int? id,
    String? name,
    String? sale_type,
    String? main_type_status,
    Category? category,
    String? description,
    int? price,
    String? currency,
    bool? is_contract,
    String? route_type,
    String? property_status,
    District? region,
    District? district,
    String? email,
    String? phone_number,
    bool? is_auto_renew,
    String? typ_status,
    String? begin_date,
    String? endDate,
    Seller? seller,
    String? createdAt,
    dynamic otherName,
    District? otherCategory,
    dynamic otherDescription,
    dynamic otherRouteType,
    dynamic otherPropertyStatus,
    String? type,
    bool? showSocial,
    int? tin,
    bool? hasFreeShipping,
    bool? hasShipping,
    bool? hasWarehouse,
    int? shippingPrice,
    int? shippingUnitId,
    int? view,
    int? selected,
    int? phoneView,
    int? messageNumber,
    dynamic typeExpireDate,
    int? unitId,
    dynamic toPrice,
    dynamic fromPrice,
    int? addressId,
    String? video,
    List<dynamic>? params,
    List<SocialMedia>? socialMedias,
    List<Address>? warehouses,
    List<Shipping>? shippings,
    List<Photo>? photos,
    Address? address,
    List<District>? paymentTypes,
  }) = _Results;

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    int? id,
    District? region,
    District? district,
    String? name,
    District? mahalla,
    String? homeNum,
    String? streetNum,
    District? floor,
    String? apartmentNum,
    String? geo,
    String? type,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class District with _$District {
  const factory District({
    int? id,
    String? name,
  }) = _District;

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    int? id,
    bool? isSell,
    String? name,
    String? keyWord,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Photo with _$Photo {
  const factory Photo({
    String? image,
    bool? isMain,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    String? fullName,
    int? id,
    int? tin,
    String? lastLoginAt,
    dynamic photo,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@freezed
class Shipping with _$Shipping {
  const factory Shipping({
    int? id,
    Type? type,
    District? district,
    District? region,
  }) = _Shipping;

  factory Shipping.fromJson(Map<String, dynamic> json) =>
      _$ShippingFromJson(json);
}

enum Type { FREE_SHIPPING, SHIPPING }

final typeValues = EnumValues(
    {"FREE_SHIPPING": Type.FREE_SHIPPING, "SHIPPING": Type.SHIPPING});

@freezed
class SocialMedia with _$SocialMedia {
  const factory SocialMedia({
    String? type,
    String? link,
  }) = _SocialMedia;

  factory SocialMedia.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaFromJson(json);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
