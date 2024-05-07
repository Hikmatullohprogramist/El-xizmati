import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_full_info_response.freezed.dart';part 'user_full_info_response.g.dart';

@freezed
class UserRootResponse with _$UserRootResponse {
  const factory UserRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required UserResponse data,
    dynamic response,
  }) = _UserRootResponse;

  factory UserRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRootResponseFromJson(json);
}

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    String? secret_key,
    String? status,
    int? id,
    dynamic photo,
    String? username,
    dynamic district_id,
    String? full_name,
    dynamic region_id,
    dynamic post_name,
    dynamic email,
    String? gender,
    dynamic telegram_id,
    dynamic message_type,
    dynamic pinfl,
    dynamic tin,
    dynamic mahalla_id,
    dynamic home_name,
    dynamic passport_number,
    dynamic passport_serial,
    bool? is_registered,
    dynamic birth_date,
    String? type_activity,
    String? mobile_phone,
    List<Active>? actives,
    List<Socials>? socials,
    UserDo? userDo,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

@freezed
class Active with _$Active {
  const factory Active({
    int? id,
    String? token,
    String? last_activity_at,
    String? last_login_at,
    String? user_agent,
    int? user_id,
    String? last_ip_address,
  }) = _Active;

  factory Active.fromJson(Map<String, dynamic> json) => _$ActiveFromJson(json);
}

@freezed
class Socials with _$Socials {
  const factory Socials({
    int? id,
    String? type,
    String? link,
    String? status,
    int? tin,
    String? viewNote,
  }) = _Socials;

  factory Socials.fromJson(Map<String, dynamic> json) =>
      _$SocialsFromJson(json);
}

@freezed
class UserDo with _$UserDo {
  const factory UserDo({
    int? id,
    dynamic pinfl,
  }) = _UserDo;

  factory UserDo.fromJson(Map<String, dynamic> json) => _$UserDoFromJson(json);
}
