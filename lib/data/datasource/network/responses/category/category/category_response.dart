import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

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
  @HiveType(typeId: 1)
  const factory CategoryResponse({
    @HiveField(1) required int id,
    @HiveField(2) String? name,
    @HiveField(3) String? key_word,
    @HiveField(4) int? parent_id,
    @HiveField(5) dynamic icon,
    @HiveField(6) dynamic icon_home,
    @HiveField(7) bool? is_home,
    @HiveField(8) String? type,
    @HiveField(9) int? amount,
  }) = _CategoryResponse;

  const CategoryResponse._();

  bool get isParent => parent_id == null || parent_id == 0;

  bool get hasAmount => amount != null && amount! > 0;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}
