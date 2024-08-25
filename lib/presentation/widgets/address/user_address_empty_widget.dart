import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';

class UserAddressEmptyWidget extends StatelessWidget {
  const UserAddressEmptyWidget({super.key, required this.onActionClicked});

  final VoidCallback onActionClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            // Assets.images.pngImages.userAddresses.image(),
            SizedBox(height: 48),
            Strings.addressEmptyTitle
                .w(500)
                .s(16)
                .c(context.textPrimary)
                .copyWith(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
            SizedBox(height: 42),
            CustomElevatedButton(
              onPressed: onActionClicked,
              text: Strings.addressAddTitle,
            )
          ],
        ),
      ),
    );
  }
}
