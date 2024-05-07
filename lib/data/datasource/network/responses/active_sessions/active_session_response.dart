import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_session_response.freezed.dart';
part 'active_session_response.g.dart';

@freezed
class ActiveSessionsRootResponse with _$ActiveSessionsRootResponse {
  const factory ActiveSessionsRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required List<ActiveSessionResponse> data,
    dynamic response,
  }) = _ActiveSessionsRootResponse;

  factory ActiveSessionsRootResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveSessionsRootResponseFromJson(json);
}

@freezed
class ActiveSessionResponse with _$ActiveSessionResponse {
  const ActiveSessionResponse._();

  const factory ActiveSessionResponse({
    required int id,
    required String token,
    String? last_activity_at,
    String? last_login_at,
    required String user_agent,
    int? user_id,
    String? last_ip_address,
  }) = _ActiveSessionResponse;

  bool isCurrentSession() => user_agent.contains("APPLICATION");

  bool get isMobile => user_agent.contains("APPLICATION");

  factory ActiveSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveSessionResponseFromJson(json);
}
