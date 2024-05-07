import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/data/datasource/network/responses/region/region_response.dart';

import 'district_response.dart';

part 'region_and_district_response.freezed.dart';
part 'region_and_district_response.g.dart';

@freezed
class RegionAndDistrictRootResponse with _$RegionAndDistrictRootResponse {
  const factory RegionAndDistrictRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required RegionAndDistrictResponse data,
    dynamic response,
  }) = _RegionAndDistrictRootResponse;

  factory RegionAndDistrictRootResponse.fromJson(Map<String, dynamic> json) =>
      _$RegionAndDistrictRootResponseFromJson(json);
}

@freezed
class RegionAndDistrictResponse with _$RegionAndDistrictResponse {
  const factory RegionAndDistrictResponse({
    required List<RegionResponse> regions,
    required List<DistrictResponse> districts,
  }) = _RegionAndDistrictResponse;

  factory RegionAndDistrictResponse.fromJson(Map<String, dynamic> json) =>
      _$RegionAndDistrictResponseFromJson(json);
}
