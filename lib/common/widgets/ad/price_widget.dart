import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/domain/util.dart';

class AppPriceWidget extends StatelessWidget {
  AppPriceWidget(
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

  var formatter = NumberFormat('###,000');

  @override
  Widget build(BuildContext context) {
    return price == 0
        ? "${formatter.format(toPrice).replaceAll(',', ' ')}-"
                "${formatter.format(fromPrice).replaceAll(',', ' ')} ${currency.getName}"
            .w(800)
            .s(16)
            .c(color != null ? color! : Color(0xFF5C6AC3))
            .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis)
        : "${formatter.format(price).replaceAll(',', ' ')} ${currency.getName}"
            .w(800)
            .s(16)
            .c(color != null ? color! : Color(0xFF5C6AC3))
            .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
