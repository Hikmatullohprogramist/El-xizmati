import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_information_response.freezed.dart';

part 'user_information_response.g.dart';

@freezed
class UserInformationRootResponse with _$UserInformationRootResponse {
  const factory UserInformationRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
   required UserInformationResponse data,
    dynamic response,
  }) = _UserInformationRootResponse;

  factory UserInformationRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInformationRootResponseFromJson(json);
}

@freezed
class UserInformationResponse with _$UserInformationResponse {
  const factory UserInformationResponse({
    int? id,
    dynamic photo,
    String? username,
    dynamic district_id,
    dynamic full_name,
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
    List<dynamic>? socials,
    UserDo? userDo,
  }) = _UserInformationResponse;

  factory UserInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInformationResponseFromJson(json);
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
class UserDo with _$UserDo {
  const factory UserDo({
    int? id,
    dynamic pinfl,
  }) = _UserDo;

  factory UserDo.fromJson(Map<String, dynamic> json) => _$UserDoFromJson(json);
}
