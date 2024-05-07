import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_result_response.freezed.dart';
part 'add_result_response.g.dart';

@freezed
class AddResultRootResponse with _$AddResultRootResponse {
  const factory AddResultRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    AddResultResponse? data,
    dynamic response,
  }) = _AddResultRootResponse;

  factory AddResultRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AddResultRootResponseFromJson(json);
}

@freezed
class AddResultResponse with _$AddResultResponse {
  const factory AddResultResponse({
    Products? products,
  }) = _AddResultResponse;

  factory AddResultResponse.fromJson(Map<String, dynamic> json) =>
      _$AddResultResponseFromJson(json);
}

@freezed
class Products with _$Products {
  const factory Products({
    int? id,
  }) = _Products;

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
}
