import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';

import '../../../domain/models/currency/currency_code.dart';

class ListPriceTextWidget extends StatelessWidget {
  ListPriceTextWidget({
    super.key,
    required this.price,
    required this.toPrice,
    required this.fromPrice,
    required this.currency,
    this.color,
  });

  final int price;
  final int toPrice;
  final int fromPrice;
  final CurrencyCode currency;
  Color? color;

  // var customSymbols = NumberSymbols(
  //     NAME: 'custom',
  //     DECIMAL_SEP: ',', // Custom decimal separator
  //     GROUP_SEP: '.',   // Custom grouping separator
  //     // PERCENT: '%',
  //     // ZERO_DIGIT: '0',
  //     // PLUS_SIGN: '+',
  //     // MINUS_SIGN: '-',
  //     // EXP_SYMBOL: 'e',
  //     // PERMILL: '\u2030',
  //     // INFINITY: '\u221e',
  //     // NAN: 'NaN',
  //     // DECIMAL_PATTERN: '#,##0.###',
  //     // SCIENTIFIC_PATTERN: '#E0',
  //     // PERCENT_PATTERN: '#,##0%',
  //     // CURRENCY_PATTERN: '¤#,##0.00',
  //     // DEF_CURRENCY_CODE: 'USD'
  // );

  var f = NumberFormat('###,000');

  @override
  Widget build(BuildContext context) {
    String priceStr = (price == 0)
        ? Strings.commonPriceFrom(
            price: "${f.format(fromPrice)} ${currency.getLocalizedName()}")
        : "${f.format(price)} ${currency.getLocalizedName()}";

    return priceStr
        .replaceAll(',', ' ')
        .w(500)
        .s(14)
        .c(color != null ? color! : Color(0xFF5C6AC3))
        .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
