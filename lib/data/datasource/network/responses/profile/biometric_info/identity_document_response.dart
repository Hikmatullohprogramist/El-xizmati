import 'package:freezed_annotation/freezed_annotation.dart';

part 'identity_document_response.freezed.dart';
part 'identity_document_response.g.dart';

@freezed
class IdentityDocumentRootResponse with _$IdentityDocumentRootResponse {
  const factory IdentityDocumentRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required BiometricInfoResponse data,
    dynamic response,
  }) = _IdentityDocumentRootResponse;

  factory IdentityDocumentRootResponse.fromJson(Map<String, dynamic> json) =>
      _$IdentityDocumentRootResponseFromJson(json);
}

@freezed
class BiometricInfoResponse with _$BiometricInfoResponse {
  const factory BiometricInfoResponse({
    PassportInfo? passportInfo,
    String? status,
    String? secret_key,
  }) = _BiometricInfoResponse;

  factory BiometricInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$BiometricInfoResponseFromJson(json);
}

@freezed
class PassportInfo with _$PassportInfo {
  const factory PassportInfo({
    int? pinfl,
    String? number,
    String? full_name,
    String? gender,
    String? series,
    String? birth_date,
    int? tin,
    int? region_id,
    int? district_id,
  }) = _PassportInfo;

  factory PassportInfo.fromJson(Map<String, dynamic> json) =>
      _$PassportInfoFromJson(json);
}
