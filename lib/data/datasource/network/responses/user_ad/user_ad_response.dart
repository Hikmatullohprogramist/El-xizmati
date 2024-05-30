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
    String? main_type_tatus,
    String? type_status,
    int? price,
    int? to_price,
    int? from_price,
    String? currency,
    bool? is_contract,
    String? sale_type,
    String? main_photo,
    String? route_type,
    String? property_status,
    String? begin_date,
    String? end_date,
    String? region,
    String? district,
    String? type,
    UserAdCategory? category,
    int? view,
    int? selected,
    int? phone_view,
    int? message_number,
    String? status,
    UserAdCategory? parent_category,
    bool? isSell,
    dynamic moderator_note,
    String? moderator_note_type,
  }) = _UserAdResponse;

  factory UserAdResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdResponseFromJson(json);
}

@freezed
class UserAdCategory with _$UserAdCategory {
  const factory UserAdCategory({
    int? id,
    bool? is_sell,
    String? name,
    String? key_word,
  }) = _UserAdCategory;

  factory UserAdCategory.fromJson(Map<String, dynamic> json) =>
      _$UserAdCategoryFromJson(json);
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
