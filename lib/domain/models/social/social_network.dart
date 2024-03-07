import 'dart:convert';

Social socialFromJson(String str) => Social.fromJson(json.decode(str));

String socialToJson(Social data) => json.encode(data.toJson());

class Social {
  List<SocialElement> socials;

  Social({
    required this.socials,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        socials: List<SocialElement>.from(
            json["socials"].map((x) => SocialElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "socials": List<dynamic>.from(socials.map((x) => x.toJson())),
      };
}

class SocialElement {
  String type;
  String link;
  String status;
  bool isLink;
  int id;
  int tin;
  String? viewNote;

  SocialElement({
    required this.type,
    required this.link,
    required this.status,
    required this.isLink,
    required this.id,
    required this.tin,
    required this.viewNote,
  });

  factory SocialElement.fromJson(Map<String, dynamic> json) => SocialElement(
        type: json["type"],
        link: json["link"],
        status: json["status"],
        isLink: json["is_link"],
        id: json["id"],
        tin: json["tin"],
        viewNote: json["view_note"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "link": link,
        "status": status,
        "is_link": isLink,
        "id": id,
        "tin": tin,
        "view_note": viewNote,
      };
}
