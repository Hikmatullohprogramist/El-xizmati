import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';

class CardEmptyBodyWidget extends StatelessWidget {
  const CardEmptyBodyWidget({
    super.key,
    required this.onAddCardClicked,
  });

  final VoidCallback onAddCardClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),
            Assets.images.pngImages.cardEmpty.image(),
            SizedBox(height: 48),
            Strings.cardEmptyTitle.w(500).s(16).c(Color(0xFF41455E)).copyWith(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start),
            SizedBox(height: 12),
            Strings.cardEmptyDescripton
                .w(400)
                .s(12)
                .c(Color(0xFF41455E))
                .copyWith(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
            SizedBox(height: 42),
            CustomElevatedButton(
              buttonWidth: double.infinity,
              text: Strings.cardAddCardTitle,
              onPressed: () => onAddCardClicked(),
            )
          ],
        ),
      ),
    );
  }
}
