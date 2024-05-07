import 'package:freezed_annotation/freezed_annotation.dart';

part 'district_response.freezed.dart';
part 'district_response.g.dart';

@freezed
class DistrictResponse with _$DistrictResponse {
  const factory DistrictResponse({
    required int id,
    required String name,
    required int reg_id,
  }) = _DistrictResponse;

  factory DistrictResponse.fromJson(Map<String, dynamic> json) =>
      _$DistrictResponseFromJson(json);
}
