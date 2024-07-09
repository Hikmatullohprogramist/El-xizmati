import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_bio_doc_response.freezed.dart';
part 'validate_bio_doc_response.g.dart';

@freezed
class ValidateBioDocResponse with _$ValidateBioDocResponse {
  const factory ValidateBioDocResponse({
    dynamic error,
    dynamic message,
    required String timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _ValidateBioDocResponse;

  factory ValidateBioDocResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateBioDocResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: "secret_key") required String secretKey,
    @JsonKey(name: "full_name") required String fullName,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
