import 'package:onlinebozor/domain/data%20class/AdModel.dart';

import '../../data/model/ads/ad/ad_response.dart';

extension AdExtension on AdResponse {
  AdModel toMap() {
    return AdModel(
      id: id ?? -1,
      name: name ?? "",
      price: price ?? -1,
      currency: currency ?? "",
      region: region ?? "",
      district: district ?? "",
      routeType: route_type.toString(),
      propertyStatus: property_status.toString(),
      type: type.toString(),
      typeStatus: type_status.toString(),
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
