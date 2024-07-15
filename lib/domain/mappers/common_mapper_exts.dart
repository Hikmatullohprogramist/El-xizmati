import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/domain/models/category/category_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';

import '../models/ad/ad_author_type.dart';
import '../models/ad/ad_item_condition.dart';
import '../models/ad/ad_priority_level.dart';
import '../models/ad/ad_transaction_type.dart';
import '../models/ad/ad_type.dart';
import '../models/currency/currency_code.dart';

extension StringMapperExts on String? {
  AdItemCondition toAdItemCondition() {
    return this?.contains("USED") == true
        ? AdItemCondition.used
        : AdItemCondition.fresh;
  }

  AdAuthorType toAdAuthorType() {
    return this?.contains("BUSINESS") == true
        ? AdAuthorType.business
        : AdAuthorType.private;
  }

  AdPriorityLevel toAdPriorityLevel() {
    return this?.contains("TOP") == true
        ? AdPriorityLevel.top
        : AdPriorityLevel.standard;
  }

  AdTransactionType toAdTransactionType() {
    return AdTransactionType.values.firstWhere(
      (e) => e.name.toUpperCase() == this?.toUpperCase(),
      orElse: () => AdTransactionType.sell,
    );
  }

  CategoryType toCategoryType() {
    return CategoryType.values.firstWhere(
      (e) => e.name.toUpperCase() == this?.toUpperCase(),
      orElse: () => CategoryType.other,
    );
  }

  CurrencyCode toCurrency() {
    return CurrencyCode.values.firstWhere(
      (e) => e.name.toUpperCase() == this?.toUpperCase(),
      orElse: () {
        switch (this) {
          case "860":
            return CurrencyCode.uzs;
          case "643":
            return CurrencyCode.rub;
          case "840":
            return CurrencyCode.usd;
          case "978":
            return CurrencyCode.eur;
          default:
            return CurrencyCode.uzs;
        }
      },
    );
  }

  UserAdStatus toUserAdStatus() {
    return UserAdStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == this?.toUpperCase(),
      orElse: () => UserAdStatus.WAIT,
    );
  }

  UserOrderStatus toUserOrderStatus() {
    return UserOrderStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == this?.toUpperCase(),
      orElse: () => UserOrderStatus.WAIT,
    );
  }
}

extension AdPropertStatusExtensions on AdItemCondition {
  String get stringValue {
    switch (this) {
      case AdItemCondition.fresh:
        return "NEW";
      case AdItemCondition.used:
        return "USED";
    }
  }
}

extension AdRouteTypeExtensions on AdAuthorType {
  String get stringValue {
    switch (this) {
      case AdAuthorType.business:
        return "business";
      case AdAuthorType.private:
        return "private";
    }
  }
}

extension AdStatusTypeExtensions on AdPriorityLevel {
  String get stringValue {
    switch (this) {
      case AdPriorityLevel.top:
        return "top";
      case AdPriorityLevel.standard:
        return "standard";
    }
  }
}

extension AdTypeStatusExtensions on AdTransactionType {
  String get stringValue {
    switch (this) {
      case AdTransactionType.sell:
        return "sell";
      case AdTransactionType.free:
        return "free";
      case AdTransactionType.exchange:
        return "exchange";
      case AdTransactionType.service:
        return "service";
      case AdTransactionType.buy:
        return "buy";
      case AdTransactionType.buy_service:
        return "buy_service";
    }
  }

  AdType adType() {
    switch (this) {
      case AdTransactionType.sell:
        return AdType.product;
      case AdTransactionType.free:
        return AdType.product;
      case AdTransactionType.exchange:
        return AdType.product;
      case AdTransactionType.service:
        return AdType.service;
      case AdTransactionType.buy:
        return AdType.product;
      case AdTransactionType.buy_service:
        return AdType.service;
    }
  }
}

extension CategoryTypeToStringExtension on CategoryType {
  String get stringValue => name.toLowerCase();
}

extension CurrencyToStringExtension on CurrencyCode {
  String currencyId() {
    switch (this) {
      case CurrencyCode.eur:
        return "978";
      case CurrencyCode.usd:
        return "840";
      case CurrencyCode.rub:
        return "643";
      case CurrencyCode.uzs:
        return "860";
    }
  }
}

extension AdTypeExtension on AdType {
  CategoryType geCategoryType() {
    switch (this) {
      case AdType.product:
        return CategoryType.product;
      case AdType.service:
        return CategoryType.service;
    }
  }
}
