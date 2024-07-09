import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_bio_doc_request.freezed.dart';
part 'validate_bio_doc_request.g.dart';

@freezed
class ValidateBioDocRequest with _$ValidateBioDocRequest {
  const factory ValidateBioDocRequest({
    @JsonKey(name: "passport_serial") required String docSeries,
    @JsonKey(name: "passport_number") required String docNumber,
    @JsonKey(name: "birth_date") required String birthDate,
  }) = _ValidateBioDocRequest;

  factory ValidateBioDocRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateBioDocRequestFromJson(json);
}
