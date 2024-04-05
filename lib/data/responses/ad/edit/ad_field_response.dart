class AdAddressResponse {
  int id;
  String? name;

  AdAddressResponse({
    required this.id,
    required this.name,
  });

  factory AdAddressResponse.fromJson(Map<String, dynamic> json) =>
      AdAddressResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AdPaymentTypeResponse {
  int id;
  String name;

  AdPaymentTypeResponse({
    required this.id,
    required this.name,
  });

  factory AdPaymentTypeResponse.fromJson(Map<String, dynamic> json) =>
      AdPaymentTypeResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AdPhotoResponse {
  String image;
  bool isMain;

  AdPhotoResponse({
    required this.image,
    required this.isMain,
  });

  factory AdPhotoResponse.fromJson(Map<String, dynamic> json) => AdPhotoResponse(
        image: json["image"],
        isMain: json["is_main"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "is_main": isMain,
      };
}
