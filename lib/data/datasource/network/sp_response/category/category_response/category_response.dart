import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_response.g.dart';

part 'category_response.freezed.dart';

@freezed
class CategoryResponse with _$CategoryResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CategoryResponse(
  Data data,
  Error error,
      ) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);
}

@freezed
class Data with _$Data {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Data(
  int page,
  int totalObjects,
  int currentPageSize,
  int limit,
  int totalPages,
  List<Results> results,
      ) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Results with _$Results {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Results(
  int id,
  String name,
  String icon,
      ) = _Results;

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);
}

@freezed
class Error with _$Error {
  const factory Error() = _Error;

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
}