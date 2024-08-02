import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/floor/entities/ad_entity.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_author_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/domain/models/ad/ad_item_condition.dart';
import 'package:onlinebozor/domain/models/ad/ad_priority_level.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';

extension AdResponseMapper on AdResponse {
  Ad toAd({
    bool? isInCart,
    bool? isFavorite,
  }) {
    return Ad(
      id: id,
      name: name ?? "",
      photo: photos?.first.image ?? "",
      price: price ?? 0,
      fromPrice: fromPrice ?? 0,
      toPrice: toPrice ?? 0,
      currencyCode: currencyId.toCurrency(),
      regionName: regionName is String ? regionName as String : "",
      districtName: districtName is String ? districtName as String : "",
      authorType: AdAuthorType.valueOrDefault(authorType),
      itemCondition: AdItemCondition.valueOrDefault(itemCondition),
      priorityLevel: AdPriorityLevel.valueOrDefault(priorityLevel),
      transactionType: AdTransactionType.valueOrDefault(transactionType),
      categoryId: category?.id ?? -1,
      categoryName: category?.name ?? "",
      sellerId: seller?.tin ?? -1,
      sellerName: seller?.name ?? "",
      maxAmount: maxAmount ?? 0,
      viewCount: viewCount ?? 0,
      isFavorite: isFavorite ?? false,
      isInCart: isInCart ?? false,
      isSort: isSort ?? 0,
      isSell: isSell ?? false,
      isCheck: false,
      backendId: backendId ?? -1,
    );
  }

  AdEntity toAdEntity({
    bool? isInCart,
    bool? isFavorite,
  }) {
    return AdEntity(
      id: id,
      backendId: backendId ?? -1,
      name: name ?? "",
      photo: photos?.first.image ?? "",
      price: price ?? 0,
      fromPrice: fromPrice ?? 0,
      toPrice: toPrice ?? 0,
      currencyCode: currencyId.toCurrency().name,
      regionName: regionName ?? "",
      districtName: districtName ?? "",
      authorType: AdAuthorType.valueOrDefault(authorType).name,
      itemCondition: AdItemCondition.valueOrDefault(itemCondition).name,
      priorityLevel: AdPriorityLevel.valueOrDefault(priorityLevel).name,
      transactionType: AdTransactionType.valueOrDefault(transactionType).name,
      categoryId: category?.id ?? -1,
      categoryName: category?.name ?? "",
      sellerId: seller?.tin ?? -1,
      sellerName: seller?.name ?? "",
      maxAmount: maxAmount ?? 0,
      viewCount: viewCount ?? 0,
      isFavorite: isFavorite,
      isInCart: isInCart,
      isSort: isSort ?? 0,
      isSell: isSell ?? false,
      isCheck: false,
    );
  }
}

extension AdPhoneMapper on AdPhotoResponse {
  AdPhotoModel toMap() {
    return AdPhotoModel(
      id: id ?? 0,
      image: image ?? "",
      isMain: is_main ?? false,
    );
  }
}

extension AdDetailResponseMapper on AdDetailResponse {
  AdDetail toMap({
    bool? isInCart,
    bool? isFavorite,
  }) {
    return AdDetail(
      adId: id,
      backendId: null,
      adName: name ?? "",
      description: (description ?? "")
          .replaceAll("<p>", "")
          .replaceAll("</p>", "")
          .replaceAll("<br>", "")
          .replaceAll("</br>", "")
          .replaceAll("<ul>", "")
          .replaceAll("</ul>", "")
          .replaceAll("</li>", "")
          .replaceAll("<li>", ""),
      categoryId: category?.id,
      categoryIsSale: category?.isSell,
      categoryKeyWord: category?.keyWord,
      categoryName: category?.name,
      photos: photos
              ?.filterIf((e) => e.image != null)
              .map((e) => e.image!)
              .toList() ??
          [],
      videoUrl: videoUrl,
      hasInstallment: hasInstallment,

      adType: AdType.valueOrDefault(adType),
      saleType: saleType ?? "",
      adTransactionType: AdTransactionType.valueOrDefault(adTransactionType),
      adAuthorType: AdAuthorType.valueOrDefault(adAuthorType),
      adItemCondition: AdItemCondition.valueOrDefault(adItemCondition),
      adPriorityLevel: AdPriorityLevel.valueOrDefault(adPriorityLevel),

      price: price ?? 0,
      fromPrice: fromPrice ?? 0,
      toPrice: toPrice ?? 0,
      currency: currency.toCurrency(),
      paymentTypes: paymentTypes
          ?.filterIf((e) => e.name != null)
          .map((e) => e.name!)
          .toList(),
      isContract: isContract ?? false,
      maxPrice: priceComparison?.maxPrice,
      minPrice: priceComparison?.minPrice,

      installmentInfo: installmentInfo?.toMap(paymentPlans),

      // sellerFullName: seller?.fullName,
      // sellerId: seller?.id,
      // sellerTin: seller?.tin,
      // sellerLastLoginAt: seller?.lastLoginAt,
      // sellerPhoto: seller?.photo,
      seller: seller?.toMap(),
      sellerEmail: email,
      sellerPhoneNumber: phoneNumber,
      regionId: region?.id,
      regionName: region?.name,
      districtId: district?.id,
      districtName: district?.name,
      addressId: addressId ?? address?.id,
      address: address,

      isAutoRenew: isAutoRenew ?? false,
      isShowSocial: isShowSocial ?? false,

      beginDate: beginDate,
      endDate: endDate,
      createdAt: createdAt,

      hasFreeShipping: hasFreeShipping,
      hasShipping: hasShipping,
      hasWarehouse: hasWarehouse,
      shippingPrice: shippingPrice,
      shippingUnitId: shippingUnitId,

      otherAdName: otherAdName,
      otherAdDescription: otherAdDescription,
      otherAdAuthorType: AdAuthorType.valueOrDefault(otherAdAuthorType),
      otherAdItemCondition:
          AdItemCondition.valueOrDefault(otherAdItemCondition),

      typeExpireDate: typeExpireDate,
      unitId: unitId,

      viewedCount: viewedCount ?? 0,
      phoneNumberViewedCount: phoneNumberViewedCount,
      smsNumberViewedCount: smsNumberViewedCount,
      favoritesCount: favoritesCount,

      isFavorite: isFavorite ?? false,
      isInCart: isInCart ?? false,

      // params: params,
      // shippings: shippings,
      // socialMedias: social_medias,
      // warehouses: warehouses,
    );
  }
}

extension AdDetailSellerResponseMapper on AdDetailSellerResponse {
  AdDetailSeller toMap() {
    return AdDetailSeller(
      id: id,
      fullName: fullName,
      tin: tin,
      lastLoginAt: lastLoginAt,
      photo: photo,
      cancelledOrdersCount: cancelledOrdersCount,
      isTrusted: isTrusted,
    );
  }
}

extension InstallmentInfoMapper on AdDetailInstallmentInfo {
  InstallmentInfo toMap(List<AdDetailInstallmentPlan>? paymentPlans) {
    return InstallmentInfo(
      monthCount: monthCount,
      monthlyPrice: monthlyPrice,
      paymentPlans: paymentPlans?.map((e) => e.toMap()).toList() ?? [],
    );
  }
}

extension InstallmentPaymentPlanMapper on AdDetailInstallmentPlan {
  InstallmentPaymentPlan toMap() {
    return InstallmentPaymentPlan(
      id: id,
      adsId: adId,
      monthCount: monthCount,
      monthlyPrice: monthlyPrice,
      startingPrice: startingPrice,
      startingPercentage: startingPercentage,
      totalPrice: totalPrice,
      overtimePrice: overtimePrice,
      overtimePercentage: overtimePercentage,
    );
  }
}

extension AdEntityMapper on AdEntity {
  Ad toAd() {
    return Ad(
      id: id,
      name: name,
      photo: photo,
      price: price,
      fromPrice: fromPrice,
      toPrice: toPrice,
      currencyCode: currencyCode.toCurrency(),
      categoryId: categoryId,
      categoryName: categoryName,
      sellerId: sellerId,
      regionName: regionName,
      districtName: districtName,
      authorType: AdAuthorType.valueOrDefault(authorType),
      itemCondition: AdItemCondition.valueOrDefault(itemCondition),
      priorityLevel: AdPriorityLevel.valueOrDefault(priorityLevel),
      transactionType: AdTransactionType.valueOrDefault(transactionType),
      isSort: isSort,
      isSell: isSell,
      isCheck: isCheck,
      maxAmount: maxAmount,
      isFavorite: isFavorite ?? false,
      isInCart: isInCart ?? false,
      sellerName: sellerName,
      viewCount: viewCount,
      backendId: backendId,
    );
  }
}

extension AdMapper on Ad {
  AdEntity toEntity({
    bool? isInCart,
    bool? isFavorite,
    int? backendId,
  }) {
    return AdEntity(
      id: id,
      name: name,
      photo: photo,
      price: price,
      fromPrice: fromPrice,
      toPrice: toPrice,
      currencyCode: currencyCode.name,
      categoryId: categoryId,
      categoryName: categoryName,
      sellerId: sellerId,
      regionName: regionName,
      districtName: districtName,
      authorType: authorType.stringValue,
      itemCondition: itemCondition.stringValue,
      priorityLevel: priorityLevel.stringValue,
      transactionType: transactionType.stringValue,
      isSort: isSort,
      isSell: isSell,
      isCheck: isCheck,
      maxAmount: maxAmount,
      isFavorite: isFavorite ?? this.isFavorite,
      isInCart: isInCart ?? this.isInCart,
      sellerName: sellerName,
      backendId: backendId ?? this.backendId,
      viewCount: viewCount,
    );
  }
}

extension UserAdMapper on UserAdResponse {
  UserAd toUserAd() {
    return UserAd(
      id: id,
      name: name,
      adTransactionType: AdTransactionType.valueOrDefault(type_status),
      price: price,
      fromPrice: from_price,
      toPrice: to_price,
      currency: currency,
      isContract: is_contract,
      saleType: sale_type,
      mainPhoto: main_photo,
      beginDate: begin_date,
      endDate: end_date,
      adAuthorType: AdAuthorType.valueOrDefault(route_type),
      adItemCondition: AdItemCondition.valueOrDefault(property_status),
      adPriorityLevel: AdPriorityLevel.valueOrDefault(type),
      category: category,
      parentCategory: parent_category,
      viewedCount: view,
      selectedCount: selected,
      phoneViewedCount: phone_view,
      messageViewedCount: message_number,
      status: status.toUserAdStatus(),
      isSell: false,
      moderatorNote: moderator_note,
      // moderatorNoteType: moderator_note_type,
    );
  }
}
