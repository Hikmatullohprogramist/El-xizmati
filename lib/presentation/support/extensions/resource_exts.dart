import 'dart:ui';

import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/models/ad/ad_action.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/domain/models/currency/currency_code.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/domain/models/report/report_reason.dart';
import 'package:onlinebozor/domain/models/report/report_type.dart';

extension AdTransactionTypeResExts on AdTransactionType {
  String getLocalizedName() {
    switch (this) {
      case AdTransactionType.sell:
        return Strings.adTransactionTypeSell;
      case AdTransactionType.free:
        return Strings.adTransactionTypeFree;
      case AdTransactionType.exchange:
        return Strings.adTransactionTypeExchange;
      case AdTransactionType.service:
        return Strings.adTransactionTypeService;
      case AdTransactionType.buy:
        return Strings.adTransactionTypeBuy;
      case AdTransactionType.buy_service:
        return Strings.adTransactionTypeBuyService;
    }
  }

  String getTransactionTypeLocalizedName() {
    switch (this) {
      case AdTransactionType.sell:
        return Strings.orderListTypeSell;
      case AdTransactionType.free:
        return Strings.orderListTypeSell;
      case AdTransactionType.exchange:
        return Strings.orderListTypeSell;
      case AdTransactionType.service:
        return Strings.orderListTypeSell;
      case AdTransactionType.buy:
        return Strings.orderListTypeBuy;
      case AdTransactionType.buy_service:
        return Strings.orderListTypeBuy;
    }
  }

  Color getTransactionTypeColor() {
    switch (this) {
      case AdTransactionType.sell:
        return Color(0xFF0096B2);
      case AdTransactionType.free:
        return Color(0xFF0096B2);
      case AdTransactionType.exchange:
        return Color(0xFF0096B2);
      case AdTransactionType.service:
        return Color(0xFF0096B2);
      case AdTransactionType.buy:
        return Color(0xFFBEA039);
      case AdTransactionType.buy_service:
        return Color(0xFFBEA039);
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

extension CurrencyExtension on CurrencyCode {
  String getLocalizedName() {
    switch (this) {
      case CurrencyCode.uzs:
        return Strings.currencyUzs;
      case CurrencyCode.usd:
        return Strings.currencyUsd;
      case CurrencyCode.eur:
        return Strings.currencyEuro;
      case CurrencyCode.rub:
        return Strings.currencyRuble;
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

extension UserOrderResExts on UserOrder {
  String getLocalizedCancelComment() {
    switch (cancelNote) {
      case "sellernone":
        return OrderCancelReason.SELLER_NOT_ANSWERED.getLocalizedName();
      case "changedidea":
        return OrderCancelReason.CHANGED_IDEA.getLocalizedName();
      case "selectedother":
        return OrderCancelReason.SELECTED_INCORRECTED_AD.getLocalizedName();
      case "other":
        return OrderCancelReason.OTHER_REASON.getLocalizedName();
      default:
    }
    return cancelNote ?? "";
  }
}

extension UserOrderStatusResExts on UserOrderStatus {
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

  Color color() {
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
        Strings.orderCancellationSellerNotAnswered,
      OrderCancelReason.CHANGED_IDEA => Strings.orderCancellationChangedIdea,
      OrderCancelReason.SELECTED_INCORRECTED_AD =>
        Strings.orderCancellationSelectedInfcorrectedAd,
      OrderCancelReason.OTHER_REASON => Strings.orderCancellationOtherReason,
    };
  }
}

extension ReportReasonExts on ReportReason {
  String getLocalizedName() {
    return switch (this) {
      ReportReason.SPAM => Strings.reportReasonSpam,
      ReportReason.FRAUD => Strings.reportReasonFraud,
      ReportReason.INSULT_OR_THREATS => Strings.reportReasonInsultOrThreats,
      ReportReason.PROHIBITED_GOODS_SERVICES =>
        Strings.reportReasonProhibitedGoodsServices,
      ReportReason.IRRELEVANT_ADS => Strings.reportReasonIrrelevantAds,
      ReportReason.PROHIBITED_SERVICE => Strings.reportReasonProhibitedService,
      ReportReason.INAPPROPRIATE_CONTENT =>
        Strings.reportReasonInappropriateContent,
      ReportReason.OTHER => Strings.reportReasonOther,
    };
  }
}

extension ReportTypeExts on ReportType {
  String getLocalizedPageTitle() {
    return switch (this) {
      ReportType.AD_BLOCK => Strings.reportAdsBlockTitle,
      ReportType.AD_REPORT => Strings.reportAdsReportTitle,
      ReportType.AUTHOR_BLOCK => Strings.reportUserBlockTitle,
      ReportType.AUTHOR_REPORT => Strings.reportUserReportTitle,
    };
  }

  String getLocalizedPageDesc() {
    return switch (this) {
      ReportType.AD_BLOCK => Strings.reportAdsBlockDesc,
      ReportType.AD_REPORT => Strings.reportAdsReportDesc,
      ReportType.AUTHOR_BLOCK => Strings.reportUserBlockDesc,
      ReportType.AUTHOR_REPORT => Strings.reportUserReportDesc,
    };
  }

  String getLocalizedAction() {
    return switch (this) {
      ReportType.AD_BLOCK => Strings.reportActionBlockAd,
      ReportType.AD_REPORT => Strings.reportActionSendReport,
      ReportType.AUTHOR_BLOCK => Strings.reportActionBlockUser,
      ReportType.AUTHOR_REPORT => Strings.reportActionSendReport,
    };
  }
}
