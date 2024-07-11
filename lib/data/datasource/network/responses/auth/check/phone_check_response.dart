import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_check_response.freezed.dart';
part 'phone_check_response.g.dart';

@freezed
class PhoneCheckResponse with _$PhoneCheckResponse {
  const factory PhoneCheckResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _PhoneCheckResponse;

  factory PhoneCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$PhoneCheckResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: "session_id") required String sessionToken,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
