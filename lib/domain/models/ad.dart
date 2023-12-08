import 'package:onlinebozor/domain/util.dart';

class Ad {
  Ad(
      {this.backendId,
      required this.id,
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
      required this.sellerName,
      required this.sellerId,
      required this.photo,
      required this.isCheck,
      required this.favorite,
      required this.isSort,
      required this.isSell,
      required this.maxAmount,
      required this.view});

  int? backendId;
  final int id;
  final String name;
  final int price;
  final Currency currency;
  final String region;
  final String district;
  final AdRouteType adRouteType;
  final AdPropertyStatus adPropertyStatus;
  final AdStatusType adStatusType;
  final AdTypeStatus adTypeStatus;
  final int fromPrice;
  final int toPrice;
  final int categoryId;
  final String categoryName;
  final int isSort;
  final bool isSell;
  final int maxAmount;
  final String sellerName;
  final int sellerId;
  final int view;
  bool favorite;
  bool isCheck;
  String photo;
}

class AdPhotoModel {
  AdPhotoModel({required this.image, required this.isMain, required this.id});

  final String image;
  final bool isMain;
  final int id;
}
