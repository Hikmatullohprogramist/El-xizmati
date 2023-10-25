import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_response.freezed.dart';

part 'ad_response.g.dart';

@freezed
class AdRootResponse with _$AdRootResponse {
  const factory AdRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    Data? data,
    dynamic response,
  }) = _AdRootResponse;

  factory AdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AdRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    int? count,
    List<AdResponse>? results,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class AdResponse with _$AdResponse {
  const factory AdResponse({
    int? id,
    String? name,
    int? price,
    String? currency,
    String? region,
    String? district,
    AdRouteType? route_type,
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

enum AdRouteType { BUSINESS, PRIVATE }

final routeTypeValues =
    EnumValues({"BUSINESS": AdRouteType.BUSINESS, "PRIVATE": AdRouteType.PRIVATE});

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
