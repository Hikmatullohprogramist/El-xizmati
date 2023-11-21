import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../gen/assets/assets.gen.dart';
import 'common_button.dart';

class CardEmptyWidget extends StatelessWidget {
  const CardEmptyWidget({super.key, required this.callBack});

  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 120),
        Assets.images.pngImages.cardEmpty.image(),
        SizedBox(height: 48),
        "Вы еще не добавили карту для оплаты"
            .w(500)
            .s(16)
            .c(Color(0xFF41455E))
            .copyWith(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start),
        SizedBox(height: 12),
        "С помощью этих карт вы можете оплатит за товар или услугу"
            .w(400)
            .s(12)
            .c(Color(0xFF41455E))
            .copyWith(
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
        SizedBox(height: 42),
        SizedBox(
            width: double.maxFinite,
            child: CommonButton(
              type: ButtonType.elevated,
              color: context.colors.buttonPrimary,
              onPressed: callBack,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    "Добавить карту".w(500).s(14).c(Colors.white)
                  ]),
            ))
      ]),
    ));
  }
}
