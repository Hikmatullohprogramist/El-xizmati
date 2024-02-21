import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

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
  @HiveType(typeId: 1)
  const factory CategorySelectionResponse({
    @HiveField(1) required int id,
    @HiveField(2) String? label,
    @HiveField(3) String? key_word,
  }) = _CategorySelectionResponse;

  factory CategorySelectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CategorySelectionResponseFromJson(json);
}
