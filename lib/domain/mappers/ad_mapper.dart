import 'package:onlinebozor/data/datasource/floor/entities/ad_entity.dart';
import 'package:onlinebozor/data/datasource/hive/hive_objects/ad/ad_hive_object.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/domain/models/ad/ad_item_condition.dart';
import 'package:onlinebozor/domain/models/ad/ad_priority_level.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';
import 'package:onlinebozor/domain/models/currency/currency_code.dart';

extension AdResponseExtension on AdResponse {
  Ad toAd({
    bool isAddedToCart = false,
    bool isFavorite = false,
  }) {
    return Ad(
      id: id,
      backendId: backendId ?? -1,
      name: name ?? "",
      photo: photos?.first.image ?? "",
      price: price ?? 0,
      fromPrice: fromPrice ?? 0,
      toPrice: toPrice ?? 0,
      currencyCode: currencyId.toCurrency(),
      regionName: regionName ?? "",
      districtName: districtName ?? "",
      authorType: authorType.toAdAuthorType(),
      itemCondition: itemCondition.toAdItemCondition(),
      priorityLevel: priorityLevel.toAdPriorityLevel(),
      transactionType: transactionType.toAdTransactionType(),
      categoryId: category?.id ?? -1,
      categoryName: category?.name ?? "",
      sellerId: seller?.tin ?? -1,
      sellerName: seller?.name ?? "",
      maxAmount: maxAmount ?? 0,
      viewCount: viewCount ?? 0,
      isFavorite: isFavorite,
      isAddedToCart: isAddedToCart,
      isSort: isSort ?? 0,
      isSell: isSell ?? false,
      isCheck: false,
    );
  }

  AdEntity toAdEntity({
    bool isAddedToCart = false,
    bool isFavorite = false,
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
      authorType: authorType.toAdAuthorType().name,
      itemCondition: itemCondition.toAdItemCondition().name,
      priorityLevel: priorityLevel.toAdPriorityLevel().name,
      transactionType: transactionType.toAdTransactionType().name,
      categoryId: category?.id ?? -1,
      categoryName: category?.name ?? "",
      sellerId: seller?.tin ?? -1,
      sellerName: seller?.name ?? "",
      maxAmount: maxAmount ?? 0,
      viewCount: viewCount ?? 0,
      isFavorite: isFavorite,
      isAddedToCart: isAddedToCart,
      isSort: isSort ?? 0,
      isSell: isSell ?? false,
      isCheck: false,
    );
  }
}

extension AdPhoneExtension on AdPhotoResponse {
  AdPhotoModel toMap() {
    return AdPhotoModel(
      id: id ?? 0,
      image: image ?? "",
      isMain: is_main ?? false,
    );
  }
}

extension AdDetailResponseExtension on AdDetailResponse {
  AdDetail toMap({bool favorite = false, bool isAddCart = false}) {
    return AdDetail(
      adId: id,
      adName: name ?? "",
      saleType: sale_type ?? "",
      mainTypeStatus: main_type_status ?? "",
      description: (description ?? "")
          .replaceAll("<p>", "")
          .replaceAll("</p>", "")
          .replaceAll("<br>", "")
          .replaceAll("</br>", "")
          .replaceAll("<ul>", "")
          .replaceAll("</ul>", "")
          .replaceAll("</li>", "")
          .replaceAll("<li>", ""),
      price: price ?? 0,
      currency: currency.toCurrency(),
      isContract: is_contract ?? false,
      adAuthorType: route_type.toAdAuthorType(),
      adItemCondition: property_status.toAdItemCondition(),
      isAutoRenew: is_autoRenew ?? false,
      adTransactionType: type_status.toAdTransactionType(),
      adPriorityLevel: type.toAdPriorityLevel(),
      showSocial: show_social ?? false,
      view: view ?? 0,
      addressId: address?.id,
      adAuthorType2: null,
      adItemCondition2: null,
      beginDate: begin_date,
      endDate: end_date,
      address: address,
      categoryId: category?.id,
      categoryIsSale: category?.is_sell,
      categoryKeyWord: category?.key_word,
      categoryName: category?.name,
      createdAt: created_at,
      email: email,
      fromPrice: from_price ?? 0,
      hasFreeShipping: has_free_shipping,
      hasShipping: has_shipping,
      hasWarehouse: has_warehouse,
      messageNumber: message_number,
      otherDescription: other_description,
      otherName: other_name,
      params: params,
      paymentTypes: payment_types,
      phoneNumber: phone_number,
      phoneView: phone_view,
      photos: photos,
      selected: selected,
      sellerFullName: seller?.full_name,
      sellerId: seller?.id,
      sellerTin: seller?.tin,
      sellerLastLoginAt: seller?.last_login_at,
      sellerPhone: seller?.photo,
      shippingPrice: shipping_price,
      shippings: shippings,
      shippingUnitId: shipping_unitId,
      socialMedias: social_medias,
      toPrice: to_price ?? 0,
      typeExpireDate: type_expire_date,
      unitId: unit_id,
      video: video,
      warehouses: warehouses,
      isFavorite: favorite,
      isAddedToCart: isAddCart,
    );
  }
}

extension AdObjectExtension on AdHiveObject {
  Ad toMap() {
    return Ad(
      backendId: backendId ?? -1,
      id: id,
      name: name,
      price: price,
      currencyCode: currency.toCurrency(),
      regionName: region,
      districtName: district,
      authorType: adRouteType.toAdAuthorType(),
      itemCondition: adPropertyStatus.toAdItemCondition(),
      priorityLevel: adStatus.toAdPriorityLevel(),
      transactionType: adTypeStatus.toAdTransactionType(),
      fromPrice: fromPrice,
      toPrice: toPrice,
      categoryId: categoryId,
      categoryName: categoryName,
      sellerName: sellerName,
      sellerId: sellerId,
      isSort: isSort,
      photo: photo,
      isSell: isSell,
      maxAmount: maxAmount,
      isFavorite: isFavorite,
      isAddedToCart: isAddedToCart,
      viewCount: view ?? 0,
      isCheck: false,
    );
  }
}

extension AdDetailExtension on AdDetail {
  Ad toMap() {
    return Ad(
      id: adId,
      photo: photos?.first.image ?? "",
      regionName: address?.region?.name ?? "",
      districtName: address?.district?.name ?? "",
      toPrice: toPrice,
      sellerId: sellerId ?? -1,
      fromPrice: fromPrice,
      categoryName: categoryName ?? "",
      categoryId: categoryId ?? -1,
      itemCondition: AdItemCondition.fresh,
      authorType: adAuthorType,
      priorityLevel: adPriorityLevel ?? AdPriorityLevel.standard,
      transactionType: adTransactionType ?? AdTransactionType.SELL,
      currencyCode: currency,
      isCheck: false,
      isSell: true,
      isSort: 0,
      maxAmount: 0,
      isFavorite: isFavorite,
      isAddedToCart: isAddedToCart,
      name: adName,
      price: price,
      sellerName: sellerFullName ?? "",
      viewCount: view,
      backendId: 0,
    );
  }
}

extension AdEntityExtension on AdEntity {
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
      authorType: authorType.toAdAuthorType(),
      itemCondition: itemCondition.toAdItemCondition(),
      priorityLevel: priorityLevel.toAdPriorityLevel(),
      transactionType: transactionType.toAdTransactionType(),
      isSort: isSort,
      isSell: isSell,
      isCheck: isCheck,
      maxAmount: maxAmount,
      isFavorite: isFavorite,
      isAddedToCart: isAddedToCart,
      sellerName: sellerName,
      backendId: backendId,
      viewCount: viewCount,
    );
  }
}

extension AdExtension on Ad {
  AdEntity toMap() {
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
      authorType: authorType.adRouteTypeToString(),
      itemCondition: itemCondition.adPropertyStatusToString(),
      priorityLevel: priorityLevel.adStatusToString(),
      transactionType: transactionType.adTypeStatusToString(),
      isSort: isSort,
      isSell: isSell,
      isCheck: isCheck,
      maxAmount: maxAmount,
      isFavorite: isFavorite,
      isAddedToCart: isAddedToCart,
      sellerName: sellerName,
      backendId: backendId,
      viewCount: viewCount,
    );
  }
}

extension UserAdExtension on UserAdResponse {
  UserAd toMap() {
    return UserAd(
      id: id,
      name: name,
      adTransactionType:
          type_status?.toAdTransactionType() ?? AdTransactionType.SELL,
      price: price,
      fromPrice: from_price,
      toPrice: to_price,
      currency: currency,
      isContract: is_contract,
      saleType: sale_type,
      mainPhoto: main_photo,
      beginDate: begin_date,
      endDate: end_date,
      adAuthorType: route_type.toAdAuthorType(),
      adItemCondition: property_status.toAdItemCondition(),
      adPriorityLevel: type.toAdPriorityLevel(),
      category: category,
      parentCategory: parent_category,
      viewedCount: view,
      selectedCount: selected,
      phoneViewedCount: phone_view,
      messageViewedCount: message_number,
      status: status.toUserAdStatus(),
      isSell: false,
      moderatorNote: moderator_note,
      moderatorNoteType: moderator_note_type,
    );
  }
}
