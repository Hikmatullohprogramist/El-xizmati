import 'package:freezed_annotation/freezed_annotation.dart';

part 'one_id_response.freezed.dart';

part 'one_id_response.g.dart';

@freezed
class OneIdRootResponse with _$OneIdRootResponse {
  const factory OneIdRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    OneIdResponse? data,
    dynamic response,
  }) = _OneIdRootResponse;

  factory OneIdRootResponse.fromJson(Map<String, dynamic> json) =>
      _$OneIdRootResponseFromJson(json);
}

@freezed
class OneIdResponse with _$OneIdResponse {
  const factory OneIdResponse({
    String? accessToken,
    String? passwordPolicy,
    bool? hasUsername,
    Profile? profile,
    bool? hasProfile,
    bool? hasPassword,
  }) = _OneIdResponse;

  factory OneIdResponse.fromJson(Map<String, dynamic> json) =>
      _$OneIdResponseFromJson(json);
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    String? name,
    String? email,
    String? username,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
