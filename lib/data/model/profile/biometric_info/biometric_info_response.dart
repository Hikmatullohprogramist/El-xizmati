import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_info_response.freezed.dart';

part 'biometric_info_response.g.dart';

@freezed
class BiometricInfoRootResponse with _$BiometricInfoRootResponse {
  const factory BiometricInfoRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required BiometricInfoResponse data,
    dynamic response,
  }) = _BiometricInfoRootResponse;

  factory BiometricInfoRootResponse.fromJson(Map<String, dynamic> json) =>
      _$BiometricInfoRootResponseFromJson(json);
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
