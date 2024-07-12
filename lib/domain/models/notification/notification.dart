class AppNotification {
  int id;
  String createdAt;
  int tinOrPinfl;
  String title;
  String message;
  String? link;
  String status;

  AppNotification({
    required this.id,
    required this.createdAt,
    required this.tinOrPinfl,
    required this.title,
    required this.message,
    required this.link,
    required this.status,
  });

  bool get isRead => status == "READ";

  bool get isUnread => status == "UNREAD";
}
