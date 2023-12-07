import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_response.freezed.dart';
part 'favorite_response.g.dart';

@freezed
class FavoriteResponse with _$FavoriteResponse {
  const factory FavoriteResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _FavoriteResponse;

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) => _$FavoriteResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    int? count,
    required List<Result> results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    required int id,
    int? num,
    String? type,
    int? product_Id,
    String? name,
    int? price,
    String? currency,
    bool? is_contract,
    String? route_type,
    String? property_status,
    bool? has_free_shipping,
    bool? has_shipping,
    bool? has_warehouse,
    String? type_status,
    Category? unit,
    String? region,
    String? district,
    int? maxAmount,
    Seller? seller,
    Category? category,
    List<Photo>? photos,
    List<Warehouse>? warehouses,
    List<PaymentType>? payment_types,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    int? id,
    String? name,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@freezed
class PaymentType with _$PaymentType {
  const factory PaymentType({
    int? id,
    int? adsId,
    String? name,
  }) = _PaymentType;

  factory PaymentType.fromJson(Map<String, dynamic> json) => _$PaymentTypeFromJson(json);
}

@freezed
class Photo with _$Photo {
  const factory Photo({
    String? image,
    bool? isMain,
    int? productId,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    int? id,
    String? name,
    String? photo,
    int? tin,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@freezed
class Warehouse with _$Warehouse {
  const factory Warehouse({
    int? id,
    String? type,
    Category? region,
    Category? district,
    String? name,
    Category? mahalla,
    String? homeNum,
    String? streetNum,
    Category? floor,
    String? apartmentNum,
    String? geo,
    int? adsId,
  }) = _Warehouse;

  factory Warehouse.fromJson(Map<String, dynamic> json) => _$WarehouseFromJson(json);
}
