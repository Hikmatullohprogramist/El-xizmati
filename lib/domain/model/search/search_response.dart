import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response.freezed.dart';

part 'search_response.g.dart';

@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    Data? data,
    dynamic response,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    List<Ad>? ads,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Ad with _$Ad {
  const factory Ad({
    int? id,
    String? name,
    int? categoryId,
    String? mainPhoto,
    int? price,
    String? type,
  }) = _Ad;

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);
}
