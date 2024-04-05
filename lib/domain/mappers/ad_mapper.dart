import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';

import '../../data/hive_objects/ad/ad_object.dart';
import '../../data/responses/ad/ad/ad_response.dart';
import '../../data/responses/ad/ad_detail/ad_detail_response.dart';
import '../models/ad/ad_detail.dart';
import '../models/ad/ad_item_condition.dart';
import '../models/ad/ad_priority_level.dart';
import '../models/ad/ad_transaction_type.dart';

extension AdResponseExtension on AdResponse {
  Ad toMap({bool favorite = false}) {
    return Ad(
        id: id,
        backendId: backet_id ?? -1,
        name: name ?? "",
        price: price ?? 0,
        currency: currency.toCurrency(),
        region: region ?? "",
        district: district ?? "",
        adRouteType: route_type.toAdAuthorType(),
        adPropertyStatus: property_status.toAdPropertyStatus(),
        adStatus: type.toAdPriorityLevel(),
        adTypeStatus: type_status.toAdTypeStatus(),
        fromPrice: from_price ?? 0,
        toPrice: to_price ?? 0,
        categoryId: category?.id ?? -1,
        categoryName: category?.name ?? "",
        sellerName: seller?.name ?? "",
        sellerId: seller?.tin ?? -1,
        isSort: is_sort ?? 0,
        photo: photos?.first.image ?? "",
        isSell: is_sell ?? false,
        maxAmount: max_amount ?? 0,
        view: view ?? 0,
        favorite: favorite,
        isCheck: false);
  }
}

extension AdPhoneExtension on AdPhotoResponse {
  AdPhotoModel toMap() {
    return AdPhotoModel(
        id: id ?? 0, image: image ?? "", isMain: is_main ?? false);
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
        adItemCondition: property_status.toAdPropertyStatus(),
        isAutoRenew: is_autoRenew ?? false,
        adTransactionType: type_status.toAdTypeStatus(),
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
        favorite: favorite,
        isAddCart: isAddCart);
  }
}

extension AdObjectExtension on AdObject {
  Ad toMap({bool favorite = false}) {
    return Ad(
        backendId: backendId ?? -1,
        id: id,
        name: name,
        price: price,
        currency: currency.toCurrency(),
        region: region,
        district: district,
        adRouteType: adRouteType.toAdAuthorType(),
        adPropertyStatus: adPropertyStatus.toAdPropertyStatus(),
        adStatus: adStatus.toAdPriorityLevel(),
        adTypeStatus: adTypeStatus.toAdTypeStatus(),
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
        favorite: favorite,
        view: view ?? 0,
        isCheck: false);
  }
}

extension AdDetailExtension on AdDetail {
  Ad toMap() {
    return Ad(
        id: adId,
        photo: photos?.first.image ?? "",
        favorite: favorite,
        region: address?.region?.name ?? "",
        district: address?.district?.name ?? "",
        toPrice: toPrice,
        sellerId: sellerId ?? -1,
        fromPrice: fromPrice,
        categoryName: categoryName ?? "",
        categoryId: categoryId ?? -1,
        adPropertyStatus: AdItemCondition.fresh,
        adRouteType: adAuthorType,
        adStatus: adPriorityLevel ?? AdPriorityLevel.standard,
        adTypeStatus: adTransactionType ?? AdTransactionType.SELL,
        currency: currency,
        isCheck: false,
        isSell: true,
        isSort: 0,
        maxAmount: 0,
        name: adName,
        price: price,
        sellerName: sellerFullName ?? "",
        view: view,
        backendId: 0);
  }
}

extension AdExtension on Ad {
  AdObject toMap({int? backendId, bool? favorite}) {
    return AdObject(
      id: id,
      name: name,
      price: price,
      currency: currency.currencyToString(),
      region: region,
      district: district,
      adRouteType: adRouteType.adRouteTypeToString(),
      adPropertyStatus: adPropertyStatus.adPropertyStatusToString(),
      adStatus: adStatus.adStatusToString(),
      adTypeStatus: adTypeStatus.adTypeStatusToString(),
      fromPrice: fromPrice,
      toPrice: toPrice,
      categoryId: categoryId,
      categoryName: categoryName,
      isSort: isSort,
      isSell: isSell,
      isCheck: isCheck,
      sellerId: sellerId,
      maxAmount: maxAmount,
      favorite: favorite ?? this.favorite,
      photo: photo,
      sellerName: sellerName,
      backendId: this.backendId ?? backendId,
      view: view,
    );
  }
}

extension UserAdExtension on UserAdResponse {
  UserAd toMap({int? backendId, bool? favorite}) {
    return UserAd(
      id: id,
      name: name,
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
      adItemCondition: property_status.toAdPropertyStatus(),
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
