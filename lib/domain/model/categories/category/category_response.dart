import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'category_response.freezed.dart';

part 'category_response.g.dart';

@freezed
@HiveType(typeId: 1)
class CategoryRootResponse with _$CategoryRootResponse {
  const factory CategoryRootResponse({
    @HiveField(1) dynamic error,
    @HiveField(2) dynamic message,
    @HiveField(3) String? timestamp,
    @HiveField(4) int? status,
    @HiveField(5) dynamic path,
    @HiveField(6) List<CategoryResponse>? data,
    @HiveField(7) dynamic response,
  }) = _CategoryRootResponse;

  factory CategoryRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryRootResponseFromJson(json);
}

@freezed
@HiveType(typeId: 2)
class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    @HiveField(1) int? id,
    @HiveField(2) dynamic name,
    @HiveField(3) String? key_word,
    @HiveField(4) int? parent_id,
    @HiveField(5) String? icon,
    @HiveField(6) String? icon_home,
    @HiveField(7) bool? is_home,
    @HiveField(8) Type? type,
    @HiveField(9) List<Param>? params,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}

@freezed
@HiveType(typeId: 3)
class Param with _$Param {
  const factory Param({
    @HiveField(1) int? id,
    @HiveField(2) dynamic name,
    @HiveField(3) int? categoryId,
    @HiveField(4) String? type,
    @HiveField(5) bool? isFilter,
  }) = _Param;

  factory Param.fromJson(Map<String, dynamic> json) => _$ParamFromJson(json);
}

enum Type { ALL, PRODUCT, SERVICE }

final typeValues = EnumValues(
    {"ALL": Type.ALL, "PRODUCT": Type.PRODUCT, "SERVICE": Type.SERVICE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
