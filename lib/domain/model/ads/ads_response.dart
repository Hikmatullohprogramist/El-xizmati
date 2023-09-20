import 'package:freezed_annotation/freezed_annotation.dart';

part 'ads_response.freezed.dart';

part 'ads_response.g.dart';

@freezed
class AdsResponse with _$AdsResponse {
  const factory AdsResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    Data? data,
    dynamic response,
  }) = _AdsResponse;

  factory AdsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdsResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    int? count,
    List<Result>? results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    int? id,
    String? name,
    int? price,
    String? currency,
    String? region,
    String? district,
    RouteType? route_type,
    PropertyStatus? property_status,
    Type? type,
    TypeStatus? type_status,
    int? from_price,
    int? to_price,
    Category? category,
    int? is_sort,
    bool? is_sell,
    int? max_amount,
    Seller? seller,
    List<Photo>? photos,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
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
class Photo with _$Photo {
  const factory Photo({
    String? image,
    bool? is_main,
    int? id,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

enum PropertyStatus { NEW, USED }

final propertyStatusValues =
    EnumValues({"NEW": PropertyStatus.NEW, "USED": PropertyStatus.USED});

enum RouteType { BUSINESS, PRIVATE }

final routeTypeValues =
    EnumValues({"BUSINESS": RouteType.BUSINESS, "PRIVATE": RouteType.PRIVATE});

enum TypeStatus { SELL, FREE, EXCHANGE, SERVICE, BUY, BUY_SERVICE }

final TypeStatusValues = EnumValues({
  "SELL": TypeStatus.SELL,
  "FREE": TypeStatus.FREE,
  "EXCHNGE": TypeStatus.EXCHANGE,
  "SERVCE": TypeStatus.SERVICE,
  "BUY": TypeStatus.BUY,
  "BUY_ERVICE": TypeStatus.SELL
});

@freezed
class Seller with _$Seller {
  const factory Seller({
    String? name,
    int? tin,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

enum Type { STANDART, TOP }

final typeValues = EnumValues({"STANDART": Type.STANDART, "TOP": Type.TOP});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
