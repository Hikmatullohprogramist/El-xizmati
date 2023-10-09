import '../constants.dart';

extension CurrencyExtension on Currency {
  String get getName => getCurrencyName(this);

  String getCurrencyName(Currency currency) {
    switch (currency) {
      case Currency.UZB:
        return "so'm";
      case Currency.USD:
        return "usd";
    }
  }
}
