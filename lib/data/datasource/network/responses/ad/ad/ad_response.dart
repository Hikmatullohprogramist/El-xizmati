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
    required AdDataResponse data,
    dynamic response,
  }) = _AdRootResponse;

  factory AdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AdRootResponseFromJson(json);
}

@freezed
class AdDataResponse with _$AdDataResponse {
  const factory AdDataResponse({
    int? count,
    required List<AdResponse> results,
  }) = _AdDataResponse;

  factory AdDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AdDataResponseFromJson(json);
}

@freezed
class AdResponse with _$AdResponse {
  const factory AdResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "backend_id") int? backendId,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "from_price") int? fromPrice,
    @JsonKey(name: "to_price") int? toPrice,
    @JsonKey(name: "currency") String? currencyId,
    @JsonKey(name: "region") String? regionName,
    @JsonKey(name: "district") String? districtName,
    @JsonKey(name: "route_type") String? authorType, //business,private,
    @JsonKey(name: "property_status") String? itemCondition, //fresh,used,
    @JsonKey(name: "type") String? priorityLevel, //top,standard,
    @JsonKey(name: "type_status") String? transactionType, //  SELL,FREE...
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "is_sort") int? isSort,
    @JsonKey(name: "is_sell") bool? isSell,
    @JsonKey(name: "max_amount") int? maxAmount,
    @JsonKey(name: "seller") Seller? seller,
    @JsonKey(name: "photos") List<AdPhotoResponse>? photos,
    @JsonKey(name: "view") int? viewCount,
  }) = _AdResponse;

  factory AdResponse.fromJson(Map<String, dynamic> json) =>
      _$AdResponseFromJson(json);
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

  factory AdPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$AdPhotoResponseFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    String? name,
    int? tin,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}
