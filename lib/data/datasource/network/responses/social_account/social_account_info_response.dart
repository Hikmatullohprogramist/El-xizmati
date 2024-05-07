import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_account_info_response.freezed.dart';
part 'social_account_info_response.g.dart';

@freezed
class SocialAccountInfoRootResponse with _$SocialAccountInfoRootResponse {
  const factory SocialAccountInfoRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<SocialAccountInfoResponse> data,
    dynamic response,
  }) = _SocialAccountInfoRootResponse;

  factory SocialAccountInfoRootResponse.fromJson(Map<String, dynamic> json) =>
      _$SocialAccountInfoRootResponseFromJson(json);
}

@freezed
class SocialAccountInfoResponse with _$SocialAccountInfoResponse {
  const factory SocialAccountInfoResponse({
    int? id,
    String? type,
    String? link,
    String? status,
    bool? is_link,
    int? tin,
    String? view_note,
  }) = _SocialAccountInfoResponse;

  factory SocialAccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$SocialAccountInfoResponseFromJson(json);
}
