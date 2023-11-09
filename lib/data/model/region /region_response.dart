import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_response.freezed.dart';

part 'region_response.g.dart';

@freezed
class RegionRootResponse with _$RegionRootResponse {
  const factory RegionRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required List<RegionResponse> data,
    dynamic response,
  }) = _RegionRootResponse;

  factory RegionRootResponse.fromJson(Map<String, dynamic> json) =>
      _$RegionRootResponseFromJson(json);
}

@freezed
class RegionResponse with _$RegionResponse {
  const factory RegionResponse({
    required int id,
    required String name,
  }) = _RegionResponse;

  factory RegionResponse.fromJson(Map<String, dynamic> json) =>
      _$RegionResponseFromJson(json);
}
