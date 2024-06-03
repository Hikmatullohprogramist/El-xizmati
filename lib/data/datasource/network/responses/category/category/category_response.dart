import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_response.freezed.dart';
part 'category_response.g.dart';

@freezed
class CategoryRootResponse with _$CategoryRootResponse {
  const factory CategoryRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<CategoryResponse> data,
  }) = _CategoryRootResponse;

  factory CategoryRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryRootResponseFromJson(json);
}

@freezed
class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    required int id,
    String? name,
    String? key_word,
    int? parent_id,
    dynamic icon,
    dynamic icon_home,
    bool? is_home,
    String? type,
    int? amount,
  }) = _CategoryResponse;

  const CategoryResponse._();

  bool get isParent => parent_id == null || parent_id == 0;

  bool get isNotParent => parent_id != null && parent_id != 0;

  bool get hasAmount => amount != null && amount! > 0;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}
