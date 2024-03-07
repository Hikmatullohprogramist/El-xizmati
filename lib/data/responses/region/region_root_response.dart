import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/data/responses/region/region_response.dart';

part 'region_root_response.freezed.dart';

part 'region_root_response.g.dart';

@freezed
class RegionRootResponse with _$RegionRootResponse {
  const factory RegionRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<RegionResponse> data,
    dynamic response,
  }) = _RegionRootResponse;

  factory RegionRootResponse.fromJson(Map<String, dynamic> json) =>
      _$RegionRootResponseFromJson(json);
}
