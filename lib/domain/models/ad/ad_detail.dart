import 'package:onlinebozor/domain/models/ad/ad_item_condition.dart';

import '../../../data/responses/ad/ad_detail/ad_detail_response.dart';
import '../currency/currency.dart';
import 'ad_author_type.dart';
import 'ad_priority_level.dart';
import 'ad_transaction_type.dart';

class AdDetail {
  AdDetail({
    required this.adId,
    this.backendId,
    required this.adName,
    required this.saleType,
    required this.mainTypeStatus,
    this.categoryId,
    this.categoryIsSale,
    this.categoryName,
    this.categoryKeyWord,
    required this.description,
    required this.price,
    required this.currency,
    required this.isContract,
    required this.adAuthorType,
    required this.adItemCondition,
    this.email,
    this.phoneNumber,
    required this.isAutoRenew,
    required this.adTransactionType,
    this.beginDate,
    this.endDate,
    this.createdAt,
    this.sellerFullName,
    this.sellerId,
    this.sellerTin,
    this.sellerLastLoginAt,
    this.sellerPhone,
    this.otherName,
    this.otherDescription,
    required this.adPriorityLevel,
    required this.showSocial,
    this.hasFreeShipping,
    this.hasShipping,
    this.hasWarehouse,
    this.shippingPrice,
    this.shippingUnitId,
    required this.view,
    this.selected,
    this.phoneView,
    this.messageNumber,
    this.typeExpireDate,
    this.unitId,
    required this.toPrice,
    required this.fromPrice,
    this.addressId,
    this.video,
    this.params,
    this.socialMedias,
    this.warehouses,
    this.shippings,
    this.photos,
    this.address,
    this.paymentTypes,
    this.adAuthorType2,
    this.adItemCondition2,
    required this.favorite,
    required this.isAddCart,
  });

  final int adId;
  int? backendId;
  String adName;
  final String saleType;
  String? mainTypeStatus;
  int? categoryId;
  bool? categoryIsSale;
  String? categoryName;
  String? categoryKeyWord;
  String? description;
  final int price;
  final Currency currency;
  bool? isContract;
  final AdAuthorType adAuthorType;
  final AdItemCondition adItemCondition;
  String? email;
  String? phoneNumber;
  final bool isAutoRenew;
  final AdTransactionType? adTransactionType;
  String? beginDate;
  String? endDate;
  String? createdAt;
  String? sellerFullName;
  int? sellerId;
  int? sellerTin;
  String? sellerLastLoginAt;
  String? sellerPhone;
  String? otherName;
  String? otherDescription;
  AdAuthorType? adAuthorType2;
  AdItemCondition? adItemCondition2;
  AdPriorityLevel? adPriorityLevel;
  final bool showSocial;
  dynamic hasFreeShipping;
  dynamic hasShipping;
  dynamic hasWarehouse;
  int? shippingPrice;
  dynamic shippingUnitId;
  final int view;
  int? selected;
  int? phoneView;
  int? messageNumber;
  dynamic typeExpireDate;
  int? unitId;
  final int toPrice;
  final int fromPrice;
  int? addressId;
  dynamic video;
  List<dynamic>? params;
  List<dynamic>? socialMedias;
  List<dynamic>? warehouses;
  List<dynamic>? shippings;
  List<Photo>? photos;
  Address? address;
  List<District>? paymentTypes;
  bool favorite;
  bool isAddCart;

  bool hasDescription() {
    return description != null && description!.isNotEmpty;
  }
}
