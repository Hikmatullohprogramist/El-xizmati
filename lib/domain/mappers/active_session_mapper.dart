import 'package:onlinebozor/data/responses/active_sessions/active_session_response.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';

extension ActiveSessionsExtension on ActiveSessionResponse {
  ActiveSession toMap(bool isCurrentSession) {
    return ActiveSession(
      id: id,
      token: token,
      lastActivityAt: last_activity_at,
      lastLoginAt: last_login_at,
      userAgent: user_agent,
      userId: user_id,
      lastIpAddress: last_ip_address,
      isCurrentSession: isCurrentSession,
    );
  }
}
