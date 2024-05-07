import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_start_response.freezed.dart';
part 'auth_start_response.g.dart';

@freezed
class AuthStartResponse with _$AuthStartResponse {
  const factory AuthStartResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _AuthStartResponse;

  factory AuthStartResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthStartResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    bool? is_registered,
    String? session_token,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
