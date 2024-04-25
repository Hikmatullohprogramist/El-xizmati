import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../domain/models/currency/currency.dart';

class DetailPriceTextWidget extends StatelessWidget {
  DetailPriceTextWidget(
      {super.key,
      required this.price,
      required this.toPrice,
      required this.fromPrice,
      required this.currency,
      this.color});

  final int price;
  final int toPrice;
  final int fromPrice;
  final Currency currency;
  Color? color;

  var format = NumberFormat('###,000');

  @override
  Widget build(BuildContext context) {
    String priceStr = "";

    if (price == 0) {
      priceStr =
      "${format.format(fromPrice).replaceAll(',', ' ')} - "
          "${format.format(toPrice).replaceAll(',', ' ')} ${currency.getLocalizedName()}";
    } else {
      priceStr =
      "${format.format(price).replaceAll(',', ' ')} ${currency.getLocalizedName()}";
    }

    return priceStr
        .w(800)
        .s(16)
        .c(color != null ? color! : Color(0xFF5C6AC3))
        .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
