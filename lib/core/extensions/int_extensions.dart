import 'package:onlinebozor/core/constants.dart';

import '../../domain/models/currency/currency_code.dart';

extension IntExtensions on int {
  String priceToFormatWithCurrency(CurrencyCode currency) {
    return "${Constants.formatter.format(this).replaceAll(',', ' ')} ${currency.name}";
  }

  String priceFromToFormatWithCurrency(CurrencyCode currency, int toPrice) {
    return "${Constants.formatter.format(this).replaceAll(',', ' ')}-${{
      Constants.formatter.format(this).replaceAll(',', ' ')
    }} ${currency.name}";
  }
}
