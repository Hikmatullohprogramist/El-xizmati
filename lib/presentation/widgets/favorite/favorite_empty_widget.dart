import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';

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
            Strings.favoriteEmptyTitle.w(500).s(16),
            SizedBox(height: 12),
            Strings.favoriteEmptyDescription.w(400).s(12),
            SizedBox(height: 42),
            CustomElevatedButton(
              backgroundColor: context.colors.buttonPrimary,
              onPressed: onActionClicked,
              text: Strings.commonOpenMain,
            )
          ],
        ),
      ),
    );
  }
}
