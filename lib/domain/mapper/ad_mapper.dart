import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';

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
      adPropertyStatus: property_status.toAdPropertyStatusMap(),
      adStatusType: type_status.toAdStatusType(),
      adTypeStatus: type.toAdTypeStatus(),
      fromPrice: from_price ?? 0,
      toPrice: to_price ?? 0,
      categoryId: category?.id ?? -1,
      categoryName: category?.name ?? "",
      sellerName: seller?.name ?? "",
      sellerId: seller?.tin ?? -1,
      photos: [],
      isSort: is_sort ?? 0,
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
