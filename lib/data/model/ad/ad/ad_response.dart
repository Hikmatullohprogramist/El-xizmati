import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_response.freezed.dart';
part 'ad_response.g.dart';

@freezed
class AdRootResponse with _$AdRootResponse {
  const factory AdRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _AdRootResponse;

  factory AdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AdRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    int? count,
    required List<AdResponse> results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class AdResponse with _$AdResponse {
  const factory AdResponse({
    required int id,
    int? backet_id,
    String? name,
    int? price,
    String? currency,
    String? region,
    String? district,
    String? route_type,
    String? property_status,
    String? type,
    String? type_status,
    int? from_price,
    int? to_price,
    Category? category,
    int? is_sort,
    bool? is_sell,
    int? max_amount,
    Seller? seller,
    List<AdPhotoResponse>? photos,
  }) = _AdResponse;

  factory AdResponse.fromJson(Map<String, dynamic> json) => _$AdResponseFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    int? id,
    String? name,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class AdPhotoResponse with _$AdPhotoResponse {
  const factory AdPhotoResponse({
    String? image,
    bool? is_main,
    int? id,
  }) = _AdPhotoResponse;

  factory AdPhotoResponse.fromJson(Map<String, dynamic> json) => _$AdPhotoResponseFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    String? name,
    int? tin,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}
