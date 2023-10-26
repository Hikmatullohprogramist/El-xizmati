class AdModel {
  AdModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.currency,
      required this.region,
      required this.district,
      required this.routeType,
      required this.propertyStatus,
      required this.type,
      required this.typeStatus,
      required this.fromPrice,
      required this.toPrice,
      required this.categoryId,
      required this.categoryName,
      required this.sellerName,
      required this.sellerId,
      required this.photos,
      required this.isSort,
      required this.isSell,
      required this.maxAmount});

  final int id;
  final String name;
  final int price;
  final String currency;
  final String region;
  final String district;
  final String routeType;
  final String propertyStatus;
  final String type;
  final String typeStatus;
  final int fromPrice;
  final int toPrice;
  final int categoryId;
  final String categoryName;
  final int isSort;
  final bool isSell;
  final int maxAmount;
  final String sellerName;
  final int sellerId;
  final List<AdPhoneModel> photos;
}

class AdPhoneModel {
  AdPhoneModel(this.image, this.isMain, this.id);

  final String image;
  final bool isMain;
  final int id;
}
