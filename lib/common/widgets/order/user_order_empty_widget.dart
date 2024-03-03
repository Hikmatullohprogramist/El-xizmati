import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';

import '../../gen/assets/assets.gen.dart';

class UserOrderEmptyWidget extends StatelessWidget {
  const UserOrderEmptyWidget({super.key, required this.onActionClicked});

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
            Assets.images.pngImages.adEmpty.image(),
            SizedBox(height: 48),
            Strings.adEmptyTitle.w(500).s(16).c(Color(0xFF41455E)).copyWith(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start),
            SizedBox(height: 12),
            Strings.adEmptyDescription
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
              child: CustomElevatedButton(
                onPressed: onActionClicked,
                text: Strings.adCreateTitle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
