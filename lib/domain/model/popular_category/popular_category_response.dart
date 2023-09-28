import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_category_response.freezed.dart';

part 'popular_category_response.g.dart';

@freezed
class PopularRootCategoryResponse with _$PopularRootCategoryResponse {
  const factory PopularRootCategoryResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    List<PopularCategoryResponse>? data,
    dynamic response,
  }) = _PopularRootCategoryResponse;

  factory PopularRootCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularRootCategoryResponseFromJson(json);
}

@freezed
class PopularCategoryResponse with _$PopularCategoryResponse {
  const factory PopularCategoryResponse({
    int? total,
    int? id,
    String? lang,
    String? icon,
    String? key,
    String? key_word,
  }) = _PopularCategoryResponse;

  factory PopularCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularCategoryResponseFromJson(json);
}
