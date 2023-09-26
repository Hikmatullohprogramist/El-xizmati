import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_response.freezed.dart';
part 'category_response.g.dart';

@freezed
class CategoryRootResponse with _$CategoryRootResponse {
  const factory CategoryRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    List<CategoryResponse>? data,
    dynamic response,
  }) = _CategoryRootResponse;

  factory CategoryRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryRootResponseFromJson(json);
}

@freezed
class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    int? id,
    dynamic name,
    String? key_word,
    int? parent_id,
    String? icon,
    String? icon_home,
    bool? is_home,
    Type? type,
    List<Param>? params,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}

@freezed
class Param with _$Param {
  const factory Param({
    int? id,
    dynamic name,
    int? categoryId,
    String? type,
    bool? isFilter,
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
