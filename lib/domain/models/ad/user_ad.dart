import 'package:onlinebozor/domain/models/ad/ad_author_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_item_condition.dart';
import 'package:onlinebozor/domain/models/ad/ad_priority_level.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';

import '../../../data/responses/ad/ad/ad_response.dart';

class UserAd {
  UserAd({
    required this.id,
    this.name,
    this.orderType,
    this.adTransactionType,
    this.price,
    this.toPrice,
    this.fromPrice,
    this.currency,
    this.isContract,
    this.saleType,
    this.mainPhoto,
    this.adAuthorType,
    this.adItemCondition,
    // this.begin_date,
    // this.end_date,
    // this.region,
    // this.district,
    this.adPriorityLevel,
    this.category,
    this.parentCategory,
    this.viewedCount,
    this.selectedCount,
    this.phoneViewedCount,
    this.messageViewedCount,
    this.status,
    this.isSell,
    this.moderatorNote,
    this.moderatorNoteType,
  });

  int id;
  String? name;
  OrderType? orderType;
  AdTransactionType? adTransactionType;
  int? price;
  int? toPrice;
  int? fromPrice;
  String? currency;
  bool? isContract;
  String? saleType;
  String? mainPhoto;
  AdAuthorType? adAuthorType;
  AdItemCondition? adItemCondition;
  // String? begin_date;
  // String? end_date;
  // String? region;
  // String? district;
  AdPriorityLevel? adPriorityLevel;
  Category? category;
  Category? parentCategory;
  int? viewedCount;
  int? selectedCount;
  int? phoneViewedCount;
  int? messageViewedCount;
  String? status;
  bool? isSell;
  dynamic moderatorNote;
  String? moderatorNoteType;
}
