import 'dart:core';

class ActiveSession {
  ActiveSession({
    required this.id,
    required this.token,
    this.lastActivityAt,
    this.lastLoginAt,
    required this.userAgent,
    this.userId,
    this.lastIpAddress,
    required this.isCurrentSession,
  });

  int id;
  String token;
  String? lastActivityAt;
  String? lastLoginAt;
  String userAgent;
  int? userId;
  String? lastIpAddress;
  bool isCurrentSession;

  bool isMobile() => userAgent.contains("Android");

  bool isMobileApp() => userAgent.contains("APPLICATION");

  bool isMacOs() => userAgent.contains("APPLICATION");

  bool isWindows() => userAgent.contains("APPLICATION");

  bool isLinux() => userAgent.contains("APPLICATION");
}
