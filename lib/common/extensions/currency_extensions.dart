import '../../domain/util.dart';

extension CurrencyExtension on Currency {
  String get getName => getCurrencyName(this);

  String getCurrencyName(Currency currency) {
    switch (currency) {
      case Currency.uzb:
        return "so'm";
      case Currency.usd:
        return "usd";
      case Currency.eur:
        return "EUR";
      case Currency.rub:
        return "RUB";
    }
  }
}
