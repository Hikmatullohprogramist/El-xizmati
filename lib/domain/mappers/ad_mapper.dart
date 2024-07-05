import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/domain/models/ad/ad_item_condition.dart';
import 'package:onlinebozor/domain/models/ad/ad_priority_level.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';

extension AdDetailExtension on AdDetail {
  Ad toAd() {
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
      transactionType: adTransactionType ?? AdTransactionType.sell,
      currencyCode: currency,
      isCheck: false,
      isSell: true,
      isSort: 0,
      maxAmount: 0,
      isFavorite: isFavorite,
      isInCart: isInCart,
      name: adName,
      price: price,
      sellerName: sellerFullName ?? "",
      viewCount: view,
      backendId: 0,
    );
  }
}
