import 'package:onlinebozor/data/model/ads/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/model/ad_detail.dart';

import '../../data/model/ads/ad/ad_response.dart';
import '../model/ad_model.dart';

extension AdExtension on AdResponse {
  AdModel toMap() {
    return AdModel(
      id: id ?? -1,
      name: name ?? "",
      price: price ?? 0,
      currency: currency.toCurrency(),
      region: region ?? "",
      district: district ?? "",
      adRouteType: route_type.toAdRouteType(),
      adPropertyStatus: property_status.toAdPropertyStatus(),
      adStatusType: type_status.toAdStatusType(),
      adTypeStatus: type.toAdTypeStatus(),
      fromPrice: from_price ?? 0,
      toPrice: to_price ?? 0,
      categoryId: category?.id ?? -1,
      categoryName: category?.name ?? "",
      sellerName: seller?.name ?? "",
      sellerId: seller?.tin ?? -1,
      isSort: is_sort ?? 0,
      photos: photos,
      isSell: is_sell ?? false,
      maxAmount: max_amount ?? 0,
    );
  }
}

extension AdPhoneExtension on AdPhotoResponse {
  AdPhotoModel toMap() {
    return AdPhotoModel(
        id: id ?? 0, image: image ?? "", isMain: is_main ?? false);
  }
}

extension AdDetailExtension on AdDetailResponse {
  AdDetail toMap() {
    return AdDetail(
        adId: id ?? -1,
        adName: name ?? "",
        saleType: sale_type ?? "",
        mainTypeStatus: main_type_status ?? "",
        description: description ?? "",
        price: price ?? 0,
        currency: currency.toCurrency(),
        isContract: is_contract ?? false,
        adRouteType: route_type.toAdRouteType(),
        propertyStatus: property_status.toAdPropertyStatus(),
        isAutoRenew: is_autoRenew ?? false,
        adTypeStatus: type_status.toAdTypeStatus(),
        adStatusType: type.toAdStatusType(),
        showSocial: show_social ?? false,
        view: view ?? 0,
        addressId: address?.id,
        otherRouteType: null,
        otherPropertyStatus: null,
        beginDate: begin_date,
        endDate: end_date,
        address: address,
        categoryId: category?.id,
        categoryIsSale: category?.is_sell,
        categoryKeyWord: category?.key_word,
        categoryName: category?.name,
        createdAt: created_at,
        email: email,
        fromPrice: from_price,
        hasFreeShipping: has_free_shipping,
        hasShipping: has_shipping,
        hasWarehouse: has_warehouse,
        messageNumber: message_number,
        otherDescription: other_description,
        otherName: other_name,
        params: params,
        paymentTypes: payment_ypes,
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
        toPrice: to_price,
        typeExpireDate: type_expire_date,
        unitId: unit_id,
        video: video,
        warehouses: warehouses);
  }
}
