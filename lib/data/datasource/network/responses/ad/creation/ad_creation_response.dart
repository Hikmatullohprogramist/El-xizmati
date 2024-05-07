import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_creation_response.freezed.dart';
part 'ad_creation_response.g.dart';

@freezed
class AdCreationRootResponse with _$AdCreationRootResponse {
  const factory AdCreationRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _AdCreationRootResponse;

  factory AdCreationRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AdCreationRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    required AdCreationResponse? insert_ad,
    required AdCreationResponse? updated_ad,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class AdCreationResponse with _$AdCreationResponse {
  const factory AdCreationResponse({
    required int id,
  }) = _AdCreationResponse;

  factory AdCreationResponse.fromJson(Map<String, dynamic> json) =>
      _$AdCreationResponseFromJson(json);
}
