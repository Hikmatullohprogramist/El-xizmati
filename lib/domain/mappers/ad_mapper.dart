import 'package:El_xizmati/domain/models/ad/ad.dart';
import 'package:El_xizmati/domain/models/ad/ad_detail.dart';
import 'package:El_xizmati/domain/models/ad/ad_item_condition.dart';
import 'package:El_xizmati/domain/models/ad/ad_priority_level.dart';
import 'package:El_xizmati/domain/models/ad/ad_transaction_type.dart';

extension AdDetailExtension on AdDetail {
  Ad toAd() {
    return Ad(
      id: adId,
      photo: photos?.first ?? "",
      regionName: address?.region?.name ?? "",
      districtName: address?.district?.name ?? "",
      toPrice: toPrice,
      sellerId: seller?.id ?? -1,
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
      sellerName: seller?.fullName ?? "",
      viewCount: viewedCount ?? 0,
      backendId: 0,
    );
  }
}
