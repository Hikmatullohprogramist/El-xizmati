import 'package:hive/hive.dart';

part 'ad_hive_object.g.dart';

@HiveType(typeId: 3)
class AdHiveObject extends HiveObject {
  AdHiveObject(
      {required this.id,
      required this.name,
      required this.price,
      required this.currency,
      required this.region,
      required this.district,
      required this.adRouteType,
      required this.adPropertyStatus,
      required this.adStatusType,
      required this.adTypeStatus,
      required this.fromPrice,
      required this.toPrice,
      required this.categoryId,
      required this.categoryName,
      required this.isSort,
      required this.isSell,
      required this.isCheck,
      required this.sellerId,
      required this.maxAmount,
      required this.favorite,
      required this.photo,
      required this.sellerName});

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int price;

  @HiveField(3)
  String currency;

  @HiveField(4)
  String region;

  @HiveField(5)
  String district;

  @HiveField(6)
  String adRouteType;

  @HiveField(7)
  String adPropertyStatus;

  @HiveField(8)
  String adStatusType;

  @HiveField(9)
  String adTypeStatus;

  @HiveField(10)
  int fromPrice;

  @HiveField(11)
  int toPrice;

  @HiveField(12)
  int categoryId;

  @HiveField(13)
  String categoryName;

  @HiveField(14)
  int isSort;

  @HiveField(15)
  bool isSell;

  @HiveField(16)
  int maxAmount;

  @HiveField(17)
  String sellerName;

  @HiveField(18)
  int sellerId;

  @HiveField(19)
  bool favorite;

  @HiveField(20)
  bool isCheck;

  @HiveField(21)
  String photo;
}
