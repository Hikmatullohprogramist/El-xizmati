import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/assets/assets.gen.dart';
import '../common_button.dart';

class AdEmptyWidget extends StatelessWidget {
  const AdEmptyWidget({super.key, required this.callBack});

  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 100),
        Assets.images.pngImages.userAddresses.image(),
        SizedBox(height: 48),
        "Вы ещё не добавили адрес, хотите добавить?"
            .w(500)
            .s(16)
            .c(Color(0xFF41455E))
            .copyWith(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start),
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
                    "Добавить".w(500).s(14).c(Colors.white)
                  ]),
            ))
      ]),
    ));
  }
}
