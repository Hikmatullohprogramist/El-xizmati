import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';

class FavoriteEmptyWidget extends StatelessWidget {
  const FavoriteEmptyWidget({
    super.key,
    required this.onActionClicked,
  });

  final VoidCallback onActionClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),
            Assets.images.pngImages.wishListShopping.image(),
            SizedBox(height: 48),
            Strings.favoriteEmptyTitle.w(500).s(16).c(Color(0xFF41455E)),
            SizedBox(height: 12),
            Strings.favoriteEmptyDescription.w(400).s(12).c(Color(0xFF41455E)),
            SizedBox(height: 42),
            CustomElevatedButton(
              backgroundColor: context.colors.buttonPrimary,
              onPressed: onActionClicked,
              text: Strings.favoriteEmptyToMain,
            )
          ],
        ),
      ),
    );
  }
}
