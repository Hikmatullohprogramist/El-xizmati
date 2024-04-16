import 'dart:ui';

import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/models/ad/ad_action.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';

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
        return Strings.userAdsAll;
      case UserAdStatus.ACTIVE:
        return Strings.userAdsActive;
      case UserAdStatus.WAIT:
        return Strings.userAdsWait;
      case UserAdStatus.INACTIVE:
        return Strings.userAdsInactive;
      case UserAdStatus.REJECTED:
        return Strings.userAdsRejected;
      case UserAdStatus.CANCELLED:
        return Strings.userAdsCancelled;
      case UserAdStatus.SYS_CANCELLED:
        return Strings.userAdsCancelled;
    }
  }

  String getLocalizedEmptyMessage() {
    switch (this) {
      case UserAdStatus.ALL:
        return Strings.adEmptyMessageAll;
      case UserAdStatus.ACTIVE:
        return Strings.adEmptyMessageActive;
      case UserAdStatus.WAIT:
        return Strings.adEmptyMessageWait;
      case UserAdStatus.INACTIVE:
        return Strings.adEmptyMessageInactive;
      case UserAdStatus.REJECTED:
        return Strings.adEmptyMessageCancelled;
      case UserAdStatus.CANCELLED:
        return Strings.adEmptyMessageCancelled;
      case UserAdStatus.SYS_CANCELLED:
        return Strings.adEmptyMessageCancelled;
    }
  }
}

extension UserOrderResExts on UserOrderStatus {
  String getLocalizedName() {
    switch (this) {
      case UserOrderStatus.ACCEPTED:
        return Strings.userOrderAccepted;
      case UserOrderStatus.ALL:
        return Strings.userOrderAll;
      case UserOrderStatus.ACTIVE:
        return Strings.userOrderActive;
      case UserOrderStatus.WAIT:
        return Strings.userOrderWait;
      case UserOrderStatus.INACTIVE:
        return Strings.userOrderInactive;
      case UserOrderStatus.REJECTED:
        return Strings.userOrderRejected;
      case UserOrderStatus.CANCELED:
        return Strings.userOrderCancelled;
      case UserOrderStatus.SYSCANCELED:
        return Strings.userOrderCancelled;
      case UserOrderStatus.IN_PROGRESS:
        return Strings.userOrderInProgress;
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
