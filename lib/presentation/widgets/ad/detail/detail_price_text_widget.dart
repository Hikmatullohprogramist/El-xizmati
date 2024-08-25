import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/data/datasource/network/constants/constants.dart';
import 'package:El_xizmati/domain/models/currency/currency_code.dart';
import 'package:El_xizmati/presentation/support/extensions/resource_exts.dart';

class DetailPriceTextWidget extends StatelessWidget {
  final int price;
  final int toPrice;
  final int fromPrice;
  final CurrencyCode currency;
  Color? color;
  final double textSize;
  final int fontWeight;

  DetailPriceTextWidget({
    super.key,
    required this.price,
    required this.toPrice,
    required this.fromPrice,
    required this.currency,
    this.color,
    this.textSize = 16,
    this.fontWeight = 800,
  });

  @override
  Widget build(BuildContext context) {
    String priceStr = "";
    var f = Constants.formatter;
    if (price == 0) {
      priceStr = "${f.format(fromPrice).replaceAll(',', ' ')} - "
          "${f.format(toPrice).replaceAll(',', ' ')} ${currency.getLocalizedName()}";
    } else {
      priceStr =
          "${f.format(price).replaceAll(',', ' ')} ${currency.getLocalizedName()}";
    }

    return priceStr
        .w(fontWeight)
        .s(textSize)
        .c(color != null ? color! : Color(0xFF5C6AC3))
        .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}
