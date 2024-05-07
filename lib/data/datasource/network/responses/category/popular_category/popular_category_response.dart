import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_category_response.freezed.dart';
part 'popular_category_response.g.dart';

@freezed
class PopularRootCategoryResponse with _$PopularRootCategoryResponse {
  const factory PopularRootCategoryResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<PopularCategory> data,
    dynamic response,
  }) = _PopularRootCategoryResponse;

  factory PopularRootCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularRootCategoryResponseFromJson(json);
}

@freezed
class PopularCategory with _$PopularCategory {
  const factory PopularCategory({
    int? total,
    required int id,
    String? name,
    String? icon,
    String? key,
    String? key_word,
  }) = _PopularCategory;

  factory PopularCategory.fromJson(Map<String, dynamic> json) =>
      _$PopularCategoryFromJson(json);
}
