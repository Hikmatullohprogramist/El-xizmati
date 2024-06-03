import 'package:onlinebozor/domain/models/currency/currency_code.dart';

import 'ad_author_type.dart';
import 'ad_item_condition.dart';
import 'ad_priority_level.dart';
import 'ad_transaction_type.dart';

class Ad {
  Ad({
    this.backendId,
    required this.id,
    required this.name,
    required this.price,
    required this.currencyCode,
    required this.regionName,
    required this.districtName,
    required this.authorType,
    required this.itemCondition,
    required this.priorityLevel,
    required this.transactionType,
    required this.fromPrice,
    required this.toPrice,
    required this.categoryId,
    required this.categoryName,
    required this.sellerName,
    required this.sellerId,
    required this.photo,
    required this.isCheck,
    required this.isFavorite,
    required this.isInCart,
    required this.isSort,
    required this.isSell,
    required this.maxAmount,
    required this.viewCount,
  });

  Ad copy() {
    return Ad(
      id: id,
      name: name,
      price: price,
      currencyCode: currencyCode,
      regionName: regionName,
      districtName: districtName,
      authorType: authorType,
      itemCondition: itemCondition,
      priorityLevel: priorityLevel,
      transactionType: transactionType,
      fromPrice: fromPrice,
      toPrice: toPrice,
      categoryId: categoryId,
      categoryName: categoryName,
      sellerName: sellerName,
      sellerId: sellerId,
      photo: photo,
      isCheck: isCheck,
      isFavorite: isFavorite,
      isInCart: isInCart,
      isSort: isSort,
      isSell: isSell,
      maxAmount: maxAmount,
      viewCount: viewCount,
    );
  }

  int? backendId;
  final int id;
  final String name;
  final int price;
  final CurrencyCode currencyCode;
  final String regionName;
  final String districtName;
  final AdAuthorType authorType;
  final AdItemCondition itemCondition;
  final AdPriorityLevel priorityLevel;
  final AdTransactionType transactionType;
  final int fromPrice;
  final int toPrice;
  final int categoryId;
  final String categoryName;
  final int isSort;
  final bool isSell;
  final int maxAmount;
  final String sellerName;
  final int sellerId;
  final int viewCount;
  bool isFavorite;
  bool isInCart;
  bool isCheck;
  String photo;

  bool hasOnlyOnePrice() {
    return price == 0;
  }

  bool get isProductAd =>
      transactionType == AdTransactionType.sell ||
      transactionType == AdTransactionType.free ||
      transactionType == AdTransactionType.exchange ||
      transactionType == AdTransactionType.buy;

  bool get isServiceAd =>
      transactionType == AdTransactionType.service ||
      transactionType == AdTransactionType.buy_service;
}

class AdPhotoModel {
  AdPhotoModel({
    required this.image,
    required this.isMain,
    required this.id,
  });

  final String image;
  final bool isMain;
  final int id;
}
