import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_response.freezed.dart';

part 'user_info_response.g.dart';

@freezed
class UserInfoRootResponse with _$UserInfoRootResponse {
  const factory UserInfoRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required UserInfoResponse data,
    dynamic response,
  }) = _UserInfoRootResponse;

  factory UserInfoRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoRootResponseFromJson(json);
}

@freezed
class UserInfoResponse with _$UserInfoResponse {
  const factory UserInfoResponse({
    required UserInfo userInfo,
  }) = _UserInfoResponse;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
}

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    int? pinfl,
    int? tin,
    String? pass_serial,
    String? pass_number,
    String? full_name,
    DateTime? birth_date,
    int? region_id,
    int? district_id,
    String? gender,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
