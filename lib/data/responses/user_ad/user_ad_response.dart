import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_ad_response.freezed.dart';

part 'user_ad_response.g.dart';

@freezed
class UserAdRootResponse with _$UserAdRootResponse {
  const factory UserAdRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _UserAdRootResponse;

  factory UserAdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    int? count,
    required List<UserAdResponse> results,
    Status? status,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class UserAdResponse with _$UserAdResponse {
  const factory UserAdResponse({
    required int id,
    String? name,
    String? mainTypeStatus,
    String? typeStatus,
    int? price,
    int? toPrice,
    int? fromPrice,
    String? currency,
    bool? isContract,
    String? saleType,
    String? mainPhoto,
    String? routeType,
    String? propertyStatus,
    String? beginDate,
    String? endDate,
    String? region,
    String? district,
    String? type,
    Category? category,
    int? view,
    int? selected,
    int? phoneView,
    int? messageNumber,
    String? status,
    Category? parentCategory,
    bool? isSell,
    dynamic moderatorNote,
    String? moderatorNoteType,
  }) = _UserAdResponse;

  factory UserAdResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdResponseFromJson(json);
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
class Status with _$Status {
  const factory Status({
    int? total,
    int? active,
    int? wait,
    int? unpaid,
    int? inactive,
    int? canceled,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
