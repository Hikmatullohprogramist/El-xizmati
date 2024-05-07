import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response.freezed.dart';
part 'search_response.g.dart';

@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    required List<AdSearchResponse> ads,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class AdSearchResponse with _$AdSearchResponse {
  const factory AdSearchResponse({
    int? id,
    String? name,
    int? categoryId,
    String? mainPhoto,
    int? price,
    String? type,
  }) = _AdSearchResponse;

  factory AdSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AdSearchResponseFromJson(json);
}
