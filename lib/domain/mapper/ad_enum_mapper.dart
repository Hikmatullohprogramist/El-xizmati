import 'package:onlinebozor/domain/model/ad_enum.dart';

extension AdEnumMapper on String? {
  AdPropertyStatus toAdPropertyStatusMap() {
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
