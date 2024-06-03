import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_response.freezed.dart';
part 'unit_response.g.dart';

@freezed
class UnitRootResponse with _$UnitRootResponse {
  const factory UnitRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<UnitResponse> data,
  }) = _UnitRootResponse;

  factory UnitRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitRootResponseFromJson(json);
}

@freezed
class UnitResponse with _$UnitResponse {
  const factory UnitResponse({
    required int id,
    String? name,
  }) = _UnitResponse;

  factory UnitResponse.fromJson(Map<String, dynamic> json) =>
      _$UnitResponseFromJson(json);
}
