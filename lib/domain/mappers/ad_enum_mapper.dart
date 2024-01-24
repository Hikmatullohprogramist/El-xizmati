

import '../models/ad/ad_author_type.dart';
import '../models/ad/ad_item_condition.dart';
import '../models/ad/ad_priority_level.dart';
import '../models/ad/ad_transaction_type.dart';
import '../models/ad/ad_type.dart';
import '../models/currency/currency.dart';

extension AdEnumMapper on String? {
  AdItemCondition toAdPropertyStatus() {
    switch (this) {
      case "NEW":
        return AdItemCondition.fresh;
      case "USED":
        AdItemCondition.used;
        return AdItemCondition.used;
      default:
        return AdItemCondition.fresh;
    }
  }

  AdAuthorType toAdRouteType() {
    switch (this) {
      case "PRIVATE":
        return AdAuthorType.private;
      case "BUSINESS":
        return AdAuthorType.business;
      default:
        return AdAuthorType.private;
    }
  }

  AdTransactionType toAdTypeStatus() {
    switch (this) {
      case "SELL":
        return AdTransactionType.sell;
      case "FREE":
        return AdTransactionType.free;
      case "EXCHANGE":
        return AdTransactionType.exchange;
      case "SERVICE":
        return AdTransactionType.service;
      case "BUY":
        return AdTransactionType.buy;
      case "BUY_SERVICE":
        return AdTransactionType.buyService;
      default:
        return AdTransactionType.sell;
    }
  }

  AdPriorityLevel toAdStatus() {
    switch (this) {
      case "TOP":
        return AdPriorityLevel.top;
      case "STANDARD":
        return AdPriorityLevel.standard;
      default:
        return AdPriorityLevel.standard;
    }
  }

  Currency toCurrency() {
    switch (this) {
      case "860":
        return Currency.uzb;
      case "643":
        return Currency.rub;
      case "840":
        return Currency.usd;
      case "978":
        return Currency.eur;
      default:
        return Currency.uzb;
    }
  }
}

extension AdPropertStatusToStringExtension on AdItemCondition {
  String adPropertyStatusToString() {
    switch (this) {
      case AdItemCondition.fresh:
        return "NEW";
      case AdItemCondition.used:
        return "USED";
    }
  }
}

extension AdRouteTypeToStringExtension on AdAuthorType {
  String adRouteTypeToString() {
    switch (this) {
      case AdAuthorType.business:
        return "PRIVATE";
      case AdAuthorType.private:
        return "BUSINESS";
    }
  }
}

extension AdTypeStatusToStringExtension on AdTransactionType {
  String adTypeStatusToString() {
    switch (this) {
      case AdTransactionType.sell:
        return "SELL";
      case AdTransactionType.free:
        return "FREE";
      case AdTransactionType.exchange:
        return "EXCHANGE";
      case AdTransactionType.service:
        return "SERVICE";
      case AdTransactionType.buy:
        return "BUY";
      case AdTransactionType.buyService:
        return "BUY_SERVICE";
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
      case AdTransactionType.buyService:
        return AdType.service;
    }
  }
}

extension AdStatusTypeToStringExtension on AdPriorityLevel {
  String adStatusToString() {
    switch (this) {
      case AdPriorityLevel.top:
        return "TOP";
      case AdPriorityLevel.standard:
        return "STANDARD";
    }
  }
}

extension CurrencyToStringExtension on Currency {
  String currencyToString() {
    switch (this) {
      case Currency.eur:
        return "978";
      case Currency.usd:
        return "840";
      case Currency.rub:
        return "643";
      case Currency.uzb:
        return "860";
    }
  }
}

extension AdTypeExtension on AdType {
  String name() {
    switch (this) {
      case AdType.product:
        return "ADS";
      case AdType.service:
        return "SERVICE";
    }
  }
}