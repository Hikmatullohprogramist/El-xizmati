import 'dart:ui';

import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';

import '../../common/gen/localization/strings.dart';
import '../../domain/models/ad/ad_transaction_type.dart';
import '../../domain/models/language/language.dart';

extension AdTransactionTypeResExts on AdTransactionType {
  String getLocalizedName() {
    switch (this) {
      case AdTransactionType.SELL:
        return Strings.adTransactionTypeSell;
      case AdTransactionType.FREE:
        return Strings.adTransactionTypeFree;
      case AdTransactionType.EXCHANGE:
        return Strings.adTransactionTypeExchange;
      case AdTransactionType.SERVICE:
        return Strings.adTransactionTypeService;
      case AdTransactionType.BUY:
        return Strings.adTransactionTypeBuy;
      case AdTransactionType.BUY_SERVICE:
        return Strings.adTransactionTypeBuyService;
    }
  }
}

extension AdTypeResExts on AdType {
  String getLocalizedName() {
    switch (this) {
      case AdType.product:
        return Strings.adTypeProductTitle;
      case AdType.service:
        return Strings.adTypeServiceTitle;
    }
  }
}

extension UserAdStatusResExts on UserAdStatus {
  String getLocalizedName() {
    switch (this) {
      case UserAdStatus.all:
        return Strings.userAdsAllLabel;
      case UserAdStatus.active:
        return Strings.userAdsActiveLabel;
      case UserAdStatus.wait:
        return Strings.userAdsPendingLabel;
      case UserAdStatus.inactive:
        return Strings.userAdsInactiveLabel;
      case UserAdStatus.rejected:
        return Strings.userAdsRejectedLabel;
      case UserAdStatus.canceled:
        return Strings.userAdsCanceledLabel;
      case UserAdStatus.sysCanceled:
        return Strings.userAdsCanceledLabel;
    }
  }
}

extension LanguageExts on Language {
  Locale getLocale() {
    return switch (this) {
      Language.uzbekLatin => Locale('uz', 'UZ'),
      Language.russian => Locale('ru', 'RU'),
      Language.uzbekCyrill => Locale('uz', 'UZK'),
    };
  }
}
