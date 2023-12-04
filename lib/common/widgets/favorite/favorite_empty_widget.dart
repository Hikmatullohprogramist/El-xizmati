import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';

class FavoriteEmptyWidget extends StatelessWidget {
  const FavoriteEmptyWidget({super.key, required this.callBack});

  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 42),
        Assets.images.pngImages.wishListShopping.image(),
        SizedBox(height: 32),
        Strings.favoriteEmptyTitle.w(500).s(16).c(Color(0xFF41455E)),
        SizedBox(height: 12),
        Strings.favoriteEmptyDescription.w(400).s(12).c(Color(0xFF41455E)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     "на".w(400).s(12).c(Color(0xFF41455E)),
        //     SizedBox(width: 5),
        //     Assets.images.icLiked.svg(),
        //     SizedBox(width: 5),
        //     "в товаре".w(400).s(12).c(Color(0xFF41455E))
        //   ],
        // ),
        SizedBox(height: 42),
        CommonButton(
            type: ButtonType.elevated,
            color: context.colors.buttonPrimary,
            onPressed: callBack,
            child: Strings.favoriteEmptyToMain.w(500).s(14).c(Colors.white))
      ]),
    );
  }
}
