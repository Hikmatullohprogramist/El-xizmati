import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_response.freezed.dart';

part 'banner_response.g.dart';

@freezed
class BannerRootResponse with _$BannerRootResponse {
  const factory BannerRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    List<BannerResponse>? data,
    dynamic response,
  }) = _BannerRootResponse;

  factory BannerRootResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerRootResponseFromJson(json);
}

@freezed
class BannerResponse with _$BannerResponse {
  const factory BannerResponse({
    int? id,
    String? actionType,
    String? actionData,
    String? image,
  }) = _BannerResponse;

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}
