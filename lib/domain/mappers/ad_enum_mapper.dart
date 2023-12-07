import 'package:onlinebozor/domain/util.dart';

extension AdEnumMapper on String? {
  AdPropertyStatus toAdPropertyStatus() {
    switch (this) {
      case "NEW":
        return AdPropertyStatus.fresh;
      case "USED":
        AdPropertyStatus.used;
        return AdPropertyStatus.used;
      default:
        return AdPropertyStatus.fresh;
    }
  }

  AdRouteType toAdRouteType() {
    switch (this) {
      case "PRIVATE":
        return AdRouteType.private;
      case "BUSINESS":
        return AdRouteType.business;
      default:
        return AdRouteType.private;
    }
  }

  AdTypeStatus toAdTypeStatus() {
    switch (this) {
      case "SELL":
        return AdTypeStatus.sell;
      case "FREE":
        return AdTypeStatus.free;
      case "EXCHANGE":
        return AdTypeStatus.exchange;
      case "SERVICE":
        return AdTypeStatus.service;
      case "BUY":
        return AdTypeStatus.buy;
      case "BUY_SERVICE":
        return AdTypeStatus.buyService;
      default:
        return AdTypeStatus.buy;
    }
  }

  AdStatusType toAdStatusType() {
    switch (this) {
      case "TOP":
        return AdStatusType.top;
      case "STANDARD":
        return AdStatusType.standard;
      default:
        return AdStatusType.standard;
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

extension AdPropertStatusToStringExtension on AdPropertyStatus {
  String adPropertyStatusToString() {
    switch (this) {
      case AdPropertyStatus.fresh:
        return "NEW";
      case AdPropertyStatus.used:
        return "USED";
    }
  }
}

extension AdRouteTypeToStringExtension on AdRouteType {
  String adRouteTypeToString() {
    switch (this) {
      case AdRouteType.business:
        return "PRIVATE";
      case AdRouteType.private:
        return "BUSINESS";
    }
  }
}

extension AdTypeStatusToStringExtension on AdTypeStatus {
  String adTypeStatusToString() {
    switch (this) {
      case AdTypeStatus.sell:
        return "SELL";
      case AdTypeStatus.free:
        return "FREE";
      case AdTypeStatus.exchange:
        return "EXCHANGE";
      case AdTypeStatus.service:
        return "SERVICE";
      case AdTypeStatus.buy:
        return "BUY";
      case AdTypeStatus.buyService:
        return "BUY_SERVICE";
    }
  }

  AdType adType() {
    switch (this) {
      case AdTypeStatus.sell:
        return AdType.ads;
      case AdTypeStatus.free:
        return AdType.ads;
      case AdTypeStatus.exchange:
        return AdType.ads;
      case AdTypeStatus.service:
        return AdType.service;
      case AdTypeStatus.buy:
        return AdType.ads;
      case AdTypeStatus.buyService:
        return AdType.service;
    }
  }
}

extension AdStatusTypeToStringExtension on AdStatusType {
  String adStatusTypeToString() {
    switch (this) {
      case AdStatusType.top:
        return "TOP";
      case AdStatusType.standard:
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
      case AdType.ads:
        return "ADS";
      case AdType.service:
        return "SERVICE";
    }
  }
}