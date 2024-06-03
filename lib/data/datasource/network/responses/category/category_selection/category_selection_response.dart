import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_selection_response.freezed.dart';
part 'category_selection_response.g.dart';

@freezed
class CategorySelectionRootResponse with _$CategorySelectionRootResponse {
  const factory CategorySelectionRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<CategorySelectionResponse> data,
  }) = _CategorySelectionRootResponse;

  factory CategorySelectionRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CategorySelectionRootResponseFromJson(json);
}

@freezed
class CategorySelectionResponse with _$CategorySelectionResponse {
  const factory CategorySelectionResponse({
    required int id,
    String? label,
    String? key_word,
  }) = _CategorySelectionResponse;

  factory CategorySelectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CategorySelectionResponseFromJson(json);
}
