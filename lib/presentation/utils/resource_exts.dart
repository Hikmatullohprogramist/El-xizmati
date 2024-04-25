import 'dart:ui';

import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/models/ad/ad_action.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';
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

  String getTransactionTypeLocalizedName() {
    switch (this) {
      case AdTransactionType.SELL:
        return Strings.orderListTypeSell;
      case AdTransactionType.FREE:
        return Strings.orderListTypeSell;
      case AdTransactionType.EXCHANGE:
        return Strings.orderListTypeSell;
      case AdTransactionType.SERVICE:
        return Strings.orderListTypeSell;
      case AdTransactionType.BUY:
        return Strings.orderListTypeBuy;
      case AdTransactionType.BUY_SERVICE:
        return Strings.orderListTypeBuy;
    }
  }

  Color getTransactionTypeColor() {
    switch (this) {
      case AdTransactionType.SELL:
        return Color(0xFF0096B2);
      case AdTransactionType.FREE:
        return Color(0xFF0096B2);
      case AdTransactionType.EXCHANGE:
        return Color(0xFF0096B2);
      case AdTransactionType.SERVICE:
        return Color(0xFF0096B2);
      case AdTransactionType.BUY:
        return Color(0xFFBEA039);
      case AdTransactionType.BUY_SERVICE:
        return Color(0xFFBEA039);
    }
  }
}

extension AdTypeResExts on AdType {
  String getLocalizedName() {
    switch (this) {
      case AdType.PRODUCT:
        return Strings.adTypeProductTitle;
      case AdType.SERVICE:
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

  Color getColor() {
    switch (this) {
      case UserAdStatus.ALL:
        return Color(0xFF010101);
      case UserAdStatus.ACTIVE:
        return Color(0xFF4BB16F);
      case UserAdStatus.WAIT:
        return Color(0xFF0060FE);
      case UserAdStatus.INACTIVE:
        return Color(0xFFF79500);
      case UserAdStatus.REJECTED:
        return Color(0xFFFB577C);
      case UserAdStatus.CANCELLED:
        return Color(0xFFFB577C);
      case UserAdStatus.SYS_CANCELLED:
        return Color(0xFFFB577C);
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

  String getLocalizedEmptyMessage() {
    switch (this) {
      case UserOrderStatus.ACCEPTED:
        return Strings.orderEmptyMessageAccepted;
      case UserOrderStatus.ALL:
        return Strings.orderEmptyMessageAll;
      case UserOrderStatus.ACTIVE:
        return Strings.orderEmptyMessageAll;
      case UserOrderStatus.WAIT:
        return Strings.orderEmptyMessageWait;
      case UserOrderStatus.INACTIVE:
        return Strings.orderEmptyMessageAll;
      case UserOrderStatus.REJECTED:
        return Strings.orderEmptyMessageRejected;
      case UserOrderStatus.CANCELED:
        return Strings.orderEmptyMessageCancelled;
      case UserOrderStatus.SYSCANCELED:
        return Strings.orderEmptyMessageCancelled;
      case UserOrderStatus.IN_PROGRESS:
        return Strings.orderEmptyMessageWait;
    }
  }

  Color getColor() {
    switch (this) {
      case UserOrderStatus.ACCEPTED:
        return Color(0xFF4BB16F);
      case UserOrderStatus.ALL:
        return Color(0xFF010101);
      case UserOrderStatus.ACTIVE:
        return Color(0xFF0060FE);
      case UserOrderStatus.WAIT:
        return Color(0xFFF79500);
      case UserOrderStatus.INACTIVE:
        return Color(0xFF010101);
      case UserOrderStatus.REJECTED:
        return Color(0xFFFB577C);
      case UserOrderStatus.CANCELED:
        return Color(0xFFFB577C);
      case UserOrderStatus.SYSCANCELED:
        return Color(0xFFFB577C);
      case UserOrderStatus.IN_PROGRESS:
        return Color(0xFFF79500);
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

extension OrderCancelReasonExts on OrderCancelReason {
  String getLocalizedName() {
    return switch (this) {
      OrderCancelReason.SELLER_NOT_ANSWERED =>
        Strings.orderCancelSellerNotAnswered,
      OrderCancelReason.CHANGED_IDEA => Strings.orderCancelChangedIdea,
      OrderCancelReason.SELECTED_INCORRECTED_AD =>
        Strings.orderCancelSelectedInfcorrectedAd,
      OrderCancelReason.OTHER_REASON => Strings.orderCancelOtherReason,
    };
  }
}
