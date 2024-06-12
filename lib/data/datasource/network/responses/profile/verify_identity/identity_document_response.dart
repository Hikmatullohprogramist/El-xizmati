import 'package:freezed_annotation/freezed_annotation.dart';

part 'identity_document_response.freezed.dart';
part 'identity_document_response.g.dart';

@freezed
class IdentityDocumentRootResponse with _$IdentityDocumentRootResponse {
  const factory IdentityDocumentRootResponse({
    dynamic error,
    dynamic message,
    required String timestamp,
    required int status,
    dynamic path,
    required IdentityDocumentInfoResponse data,
    dynamic response,
  }) = _IdentityDocumentRootResponse;

  factory IdentityDocumentRootResponse.fromJson(Map<String, dynamic> json) =>
      _$IdentityDocumentRootResponseFromJson(json);
}

@freezed
class IdentityDocumentInfoResponse with _$IdentityDocumentInfoResponse {
  const factory IdentityDocumentInfoResponse({
    IdentityDocumentResponse? passportInfo,
    String? status,
    String? secretKey,
  }) = _IdentityDocumentInfoResponse;

  factory IdentityDocumentInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$IdentityDocumentInfoResponseFromJson(json);
}

@freezed
class IdentityDocumentResponse with _$IdentityDocumentResponse {
  const factory IdentityDocumentResponse({
    @JsonKey(name: "pinfl") int? pinfl,
    @JsonKey(name: "number") String? number,
    @JsonKey(name: "full_name") String? fullName,
    @JsonKey(name: "gender") String? gender,
    @JsonKey(name: "series") String? series,
    @JsonKey(name: "birth_date") String? birthDate,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "region_id") int? regionId,
    @JsonKey(name: "district_id") int? districtId,
  }) = _IdentityDocumentResponse;

  factory IdentityDocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$IdentityDocumentResponseFromJson(json);
}
