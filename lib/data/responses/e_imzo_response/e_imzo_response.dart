class EImzoModel {
  int? status;
  String? siteId;
  String? documentId;
  String? challange;

  EImzoModel({this.status, this.siteId, this.documentId, this.challange});

  EImzoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    siteId = json['siteId'];
    documentId = json['documentId'];
    challange = json['challange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['siteId'] = this.siteId;
    data['documentId'] = this.documentId;
    data['challange'] = this.challange;
    return data;
  }
}