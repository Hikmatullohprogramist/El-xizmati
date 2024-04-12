import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_detail_response.freezed.dart';
part 'ad_detail_response.g.dart';

@freezed
class AdDetailRootResponse with _$AdDetailRootResponse {
  const factory AdDetailRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _AdDetailRootResponse;

  factory AdDetailRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
   required AdDetailResponse results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class AdDetailResponse with _$AdDetailResponse {
  const factory AdDetailResponse({
    required int id,
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
    AdDetailDistrictResponse? region,
    AdDetailDistrictResponse? district,
    dynamic email,
    String? phone_number,
    bool? is_autoRenew,
    String? type_status,
    String? begin_date,
    String? end_date,
    Seller? seller,
    String? created_at,
    dynamic other_name,
    AdDetailDistrictResponse? other_category,
    dynamic other_description,
    dynamic other_route_type,
    dynamic other_property_status,
    String? type,
    bool? show_social,
    int? tin,
    dynamic has_free_shipping,
    dynamic has_shipping,
    dynamic has_warehouse,
    int? shipping_price,
    dynamic shipping_unitId,
    int? view,
    int? selected,
    int? phone_view,
    int? message_number,
    dynamic type_expire_date,
    int? unit_id,
    int? to_price,
    int? from_price,
    int? address_id,
    dynamic video,
    List<dynamic>? params,
    List<dynamic>? social_medias,
    List<dynamic>? warehouses,
    List<dynamic>? shippings,
    List<Photo>? photos,
    AdDetailAddressResponse? address,
    List<AdDetailDistrictResponse>? payment_types,
  }) = _AdDetailResponse;

  factory AdDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailResponseFromJson(json);
}

@freezed
class AdDetailAddressResponse with _$AdDetailAddressResponse {
  const factory AdDetailAddressResponse({
    int? id,
    AdDetailDistrictResponse? region,
    AdDetailDistrictResponse? district,
    String? name,
    AdDetailDistrictResponse? mahalla,
    dynamic home_num,
    dynamic street_num,
    AdDetailDistrictResponse? floor,
    dynamic apartment_num,
    String? geo,
  }) = _Address;

  factory AdDetailAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailAddressResponseFromJson(json);
}

@freezed
class AdDetailDistrictResponse with _$AdDetailDistrictResponse {
  const factory AdDetailDistrictResponse({
    int? id,
    String? name,
  }) = _District;

  factory AdDetailDistrictResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDetailDistrictResponseFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    int? id,
    bool? is_sell,
    String? name,
    String? key_word,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Photo with _$Photo {
  const factory Photo({
    String? image,
    bool? is_main,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    String? full_name,
    int? id,
    int? tin,
    String? last_login_at,
    dynamic photo,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}
