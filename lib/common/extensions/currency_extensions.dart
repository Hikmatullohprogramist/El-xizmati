import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../domain/models/currency/currency.dart';

extension CurrencyExtension on Currency {
  String get getName => getCurrencyName(this);

  String getCurrencyName(Currency currency) {
    switch (currency) {
      case Currency.uzb:
        return Strings.currencyUzb;
      case Currency.usd:
        return "usd";
      case Currency.eur:
        return "EUR";
      case Currency.rub:
        return "RUB";
    }
  }
}
