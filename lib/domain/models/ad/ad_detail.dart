import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/domain/models/ad/ad_item_condition.dart';
import 'package:onlinebozor/domain/models/currency/currency_code.dart';

import 'ad_author_type.dart';
import 'ad_priority_level.dart';
import 'ad_transaction_type.dart';
import 'ad_type.dart';

class AdDetail {
  final int adId;
  int? backendId;
  final String adName;
  final String? description;
  final int? categoryId;
  final bool? categoryIsSale;
  final String? categoryName;
  final String? categoryKeyWord;
  final List<String>? photos;
  final String? videoUrl;
  final bool? hasInstallment;

  final AdType? adType;
  final String saleType;
  final AdTransactionType? adTransactionType;
  final AdItemCondition adItemCondition;
  final AdPriorityLevel? adPriorityLevel;

  final int price;
  final int toPrice;
  final int fromPrice;
  final CurrencyCode currency;
  final List<String>? paymentTypes;

  final InstallmentInfo? installmentInfo;

  final double? maxPrice;
  final double? minPrice;
  final bool? isContract;

  final AdDetailSeller? seller;

  // final int? sellerId;
  // final int? sellerTin;
  // final String? sellerFullName;
  // final String? sellerLastLoginAt;
  // final String? sellerPhoto;
  final AdAuthorType adAuthorType;
  final String? sellerEmail;
  final String? sellerPhoneNumber;
  final int? regionId;
  final String? regionName;
  final int? districtId;
  final String? districtName;
  final int? addressId;
  final AdDetailAddressResponse? address;

  final bool isAutoRenew;
  final bool isShowSocial;

  final String? beginDate;
  final String? endDate;
  final String? createdAt;

  final String? otherAdName;
  final String? otherAdDescription;
  final AdAuthorType? otherAdAuthorType;
  final AdItemCondition? otherAdItemCondition;

  final bool? hasFreeShipping;
  final bool? hasShipping;
  final bool? hasWarehouse;
  final int? shippingPrice;
  final int? shippingUnitId;

  final int? viewedCount;
  final int? favoritesCount;
  final int? phoneNumberViewedCount;
  final int? smsNumberViewedCount;

  dynamic typeExpireDate;
  final int? unitId;

  // List<dynamic>? params;
  // List<dynamic>? socialMedias;
  // List<dynamic>? warehouses;
  // List<dynamic>? shippings;

  bool isFavorite;
  bool isInCart;

  bool hasDescription() {
    return description != null && description!.isNotEmpty;
  }

  bool hasRangePrice() {
    return fromPrice > 0 || toPrice > 0;
  }

  AdDetail({
    required this.adId,
    required this.backendId,
    required this.adName,
    required this.description,
    required this.categoryId,
    required this.categoryIsSale,
    required this.categoryName,
    required this.categoryKeyWord,
    required this.photos,
    required this.videoUrl,
    required this.hasInstallment,
//
    required this.adType,
    required this.saleType,
    required this.adTransactionType,
    required this.adItemCondition,
    required this.adPriorityLevel,
//
    required this.price,
    required this.toPrice,
    required this.fromPrice,
    required this.currency,
    required this.paymentTypes,
    required this.isContract,
    required this.maxPrice,
    required this.minPrice,
//
    required this.installmentInfo,
//
    required this.seller,
    // required this.sellerId,
    // required this.sellerFullName,
    // required this.sellerTin,
    // required this.sellerLastLoginAt,
    // required this.sellerPhoto,
    required this.sellerEmail,
    required this.sellerPhoneNumber,
    required this.adAuthorType,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    required this.addressId,
    required this.address,
//
    required this.isAutoRenew,
    required this.isShowSocial,
//
    required this.beginDate,
    required this.endDate,
    required this.createdAt,
//
    required this.otherAdName,
    required this.otherAdDescription,
    required this.otherAdAuthorType,
    required this.otherAdItemCondition,
//
    required this.hasFreeShipping,
    required this.hasShipping,
    required this.hasWarehouse,
    required this.shippingPrice,
    required this.shippingUnitId,
//
    required this.viewedCount,
    required this.favoritesCount,
    required this.phoneNumberViewedCount,
    required this.smsNumberViewedCount,
//
    required this.typeExpireDate,
    required this.unitId,
//
    required this.isFavorite,
    required this.isInCart,
//
    // this.params,
    // this.socialMedias,
    // this.warehouses,
    // this.shippings,
  });

  List<String> get actualAdPhotos =>
      photos?.map((e) => e).toSet().toList() ?? [];

  bool get hasAddress => districtName != null;

  String get actualAddress => districtName ?? "";
}

class AdDetailSeller {
  final int? id;
  final String? fullName;
  final int? tin;
  final String? lastLoginAt;
  final String? photo;
  final int? cancelledOrdersCount;
  final bool? isTrusted;

  AdDetailSeller({
    required this.id,
    required this.fullName,
    required this.tin,
    required this.lastLoginAt,
    required this.photo,
    required this.cancelledOrdersCount,
    required this.isTrusted,
  });
}

class InstallmentInfo {
  int monthCount;
  double monthlyPrice;
  List<InstallmentPaymentPlan> paymentPlans;

  InstallmentInfo({
    required this.monthCount,
    required this.monthlyPrice,
    required this.paymentPlans,
  });

  String get info => "$monthlyPrice so'm / $monthCount oy";
}

class InstallmentPaymentPlan {
  int id;
  int adsId;
  int monthCount;
  double monthlyPrice;
  double startingPrice;
  double startingPercentage;
  double totalPrice;
  double overtimePrice;
  double overtimePercentage;

  InstallmentPaymentPlan({
    required this.id,
    required this.adsId,
    required this.monthCount,
    required this.monthlyPrice,
    required this.startingPrice,
    required this.startingPercentage,
    required this.totalPrice,
    required this.overtimePrice,
    required this.overtimePercentage,
  });
}
