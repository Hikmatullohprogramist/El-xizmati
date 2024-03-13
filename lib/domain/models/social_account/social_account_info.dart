class SocialAccountInfo {
  SocialAccountInfo({
    required this.id,
    required this.type,
    required this.link,
    required this.status,
    required this.isLink,
    required this.tin,
    this.viewNote,
  });

  int id;
  String type;
  String link;
  String status;
  bool isLink;
  int tin;
  String? viewNote;
}
