import '../currency/currency_code.dart';
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
    required this.currency,
    required this.region,
    required this.district,
    required this.adRouteType,
    required this.adPropertyStatus,
    required this.adStatus,
    required this.adTypeStatus,
    required this.fromPrice,
    required this.toPrice,
    required this.categoryId,
    required this.categoryName,
    required this.sellerName,
    required this.sellerId,
    required this.photo,
    required this.isCheck,
    required this.isFavorite,
    required this.isAddedToCart,
    required this.isSort,
    required this.isSell,
    required this.maxAmount,
    required this.view,
  });

  Ad copy() {
    return Ad(
      id: id,
      name: name,
      price: price,
      currency: currency,
      region: region,
      district: district,
      adRouteType: adRouteType,
      adPropertyStatus: adPropertyStatus,
      adStatus: adStatus,
      adTypeStatus: adTypeStatus,
      fromPrice: fromPrice,
      toPrice: toPrice,
      categoryId: categoryId,
      categoryName: categoryName,
      sellerName: sellerName,
      sellerId: sellerId,
      photo: photo,
      isCheck: isCheck,
      isFavorite: isFavorite,
      isAddedToCart: isAddedToCart,
      isSort: isSort,
      isSell: isSell,
      maxAmount: maxAmount,
      view: view,
    );
  }

  int? backendId;
  final int id;
  final String name;
  final int price;
  final CurrencyCode currency;
  final String region;
  final String district;
  final AdAuthorType adRouteType;
  final AdItemCondition adPropertyStatus;
  final AdPriorityLevel adStatus;
  final AdTransactionType adTypeStatus;
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
  bool isFavorite;
  bool isAddedToCart;
  bool isCheck;
  String photo;

  bool hasOnlyOnePrice() {
    return price == 0;
  }
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
