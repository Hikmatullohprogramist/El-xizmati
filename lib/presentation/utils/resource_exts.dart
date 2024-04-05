import 'dart:ui';

import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/models/ad/ad_action.dart';
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

extension AdActionResExts on AdAction {
  String getLocalizedName() {
    switch (this) {
      case AdAction.ACTION_EDIT:
        return Strings.actionEdit;
      case AdAction.ACTION_ADVERTISE:
        return Strings.actionAdvertise;
      case AdAction.ACTION_DEACTIVATE:
        return Strings.actionDeactivate;
      case AdAction.ACTION_ACTIVATE:
        return Strings.actionActivate;
      case AdAction.ACTION_DELETE:
        return Strings.actionDelete;
    }
  }

  SvgGenImage getActionIcon() {
    switch (this) {
      case AdAction.ACTION_EDIT:
        return Assets.images.icActionEdit;
      case AdAction.ACTION_ADVERTISE:
        return Assets.images.icActionEdit;
      case AdAction.ACTION_DEACTIVATE:
        return Assets.images.icActionDeactivate;
      case AdAction.ACTION_ACTIVATE:
        return Assets.images.icActionActivate;
      case AdAction.ACTION_DELETE:
        return Assets.images.icActionDelete;
    }
  }
}

extension UserAdStatusResExts on UserAdStatus {
  String getLocalizedName() {
    switch (this) {
      case UserAdStatus.ALL:
        return Strings.userAdsAllLabel;
      case UserAdStatus.ACTIVE:
        return Strings.userAdsActiveLabel;
      case UserAdStatus.WAIT:
        return Strings.userAdsPendingLabel;
      case UserAdStatus.INACTIVE:
        return Strings.userAdsInactiveLabel;
      case UserAdStatus.REJECTED:
        return Strings.userAdsRejectedLabel;
      case UserAdStatus.CANCELLED:
        return Strings.userAdsCanceledLabel;
      case UserAdStatus.SYS_CANCELLED:
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
