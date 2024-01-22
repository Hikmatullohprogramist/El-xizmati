import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/domain/util.dart';

import '../../gen/localization/strings.dart';

class ListPriceTextWidget extends StatelessWidget {
  ListPriceTextWidget(
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
      priceStr = Strings.priceFrom(
          price:
              "${format.format(fromPrice).replaceAll(',', ' ')} ${currency.getName}");
    } else {
      priceStr =
          "${format.format(price).replaceAll(',', ' ')} ${currency.getName}";
    }

    return priceStr
        .w(800)
        .s(13)
        .c(color != null ? color! : Color(0xFF5C6AC3))
        .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
