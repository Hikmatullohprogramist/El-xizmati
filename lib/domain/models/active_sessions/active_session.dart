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

  bool isMobileBrowser() =>
      userAgent.contains("Android") || userAgent.contains("iOS");

  bool isMobileApp() => userAgent.contains("APPLICATION");

  bool isMobileBrowserOrApp() => isMobileBrowser() || isMobileApp();

  bool isMacOs() => userAgent.contains("Macintosh");

  bool isWindows() => userAgent.contains("Windows");
}
