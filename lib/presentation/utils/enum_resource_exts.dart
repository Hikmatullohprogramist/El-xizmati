import '../../common/gen/localization/strings.dart';
import '../../domain/models/ad/ad_transaction_type.dart';

extension AdTransactionTypeResExts on AdTransactionType {
  String getString() {
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
