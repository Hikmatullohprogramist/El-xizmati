import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:flutter/services.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({
    super.key,
    required this.title,
    required this.onCloseClicked,
    this.centerTitle = false,
  });

  final String title;
  final VoidCallback onCloseClicked;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: centerTitle ? 56 : 16),
        Expanded(
          child: title.s(18).w(600).copyWith(
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        IconButton(
          onPressed: () {
            onCloseClicked();
            // HapticFeedback.lightImpact();
          },
          icon: Assets.images.icClose.svg(width: 24, height: 24),
        ),
        SizedBox(width: 6),
      ],
    );
  }
}
