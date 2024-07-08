import 'package:onlinebozor/domain/models/ad/ad_author_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_item_condition.dart';
import 'package:onlinebozor/domain/models/ad/ad_priority_level.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';

import '../../../data/datasource/network/responses/user_ad/user_ad_response.dart';


class UserAd {
  UserAd({
    required this.id,
    this.name,
    this.orderType,
    required this.adTransactionType,
    this.price,
    this.toPrice,
    this.fromPrice,
    this.currency,
    this.isContract,
    this.saleType,
    this.mainPhoto,
    this.region,
    this.district,
    this.beginDate,
    this.endDate,
    this.adAuthorType,
    this.adItemCondition,
    this.adPriorityLevel,
    this.category,
    this.parentCategory,
    this.viewedCount,
    this.selectedCount,
    this.phoneViewedCount,
    this.messageViewedCount,
    required this.status,
    this.isSell,
    this.moderatorNote,
    this.moderatorNoteType,
  });

  int id;
  String? name;
  OrderType? orderType;
  AdTransactionType adTransactionType;
  int? price;
  int? toPrice;
  int? fromPrice;
  String? currency;
  bool? isContract;
  String? saleType;
  String? mainPhoto;
  String? beginDate;
  String? region;
  String? district;
  String? endDate;
  AdAuthorType? adAuthorType;
  AdItemCondition? adItemCondition;
  AdPriorityLevel? adPriorityLevel;
  UserAdCategory? category;
  UserAdCategory? parentCategory;
  int? viewedCount;
  int? selectedCount;
  int? phoneViewedCount;
  int? messageViewedCount;
  UserAdStatus status;
  bool? isSell;
  dynamic moderatorNote;
  String? moderatorNoteType;

  bool hasPrice() {
    return (price != null && price! > 0) ||
        (toPrice != null && toPrice! > 0 && fromPrice != null && toPrice! > 0);
  }

  bool isCanActivate() {
    return status == UserAdStatus.INACTIVE;
  }

  bool isCanDeactivate() {
    return [
      UserAdStatus.ALL,
      UserAdStatus.ACTIVE,
      UserAdStatus.WAIT,
    ].contains(status);
  }

  bool isCanDelete() {
    return [
      UserAdStatus.INACTIVE,
      UserAdStatus.REJECTED,
      UserAdStatus.CANCELED,
    ].contains(status);
  }

  bool isCanAdvertise() {
    return false;
  }
}
