import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';

class ChipItem extends StatelessWidget {
  const ChipItem({
    super.key,
    required this.item,
    required this.title,
    this.onChipClicked,
    this.onActionClicked,
  });

  final dynamic item;
  final String title;
  final Function(dynamic item)? onChipClicked;
  final Function(dynamic item)? onActionClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChipClicked != null) onChipClicked!(item);
      },
      child: Container(
        padding: EdgeInsets.only(left: 14, top: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xFF5C6AC4).withOpacity(0.12),
          borderRadius: BorderRadius.all(Radius.circular(24)),
          border: Border.all(
            color: Color(0xFF5C6AC4).withOpacity(0.15),
            width: 0.5,
          ),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title
                .w(600)
                .s(13)
                .c(Color(0xFF5C6AC4))
                .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(width: 14),
            Visibility(
              visible: onActionClicked != null,
              child: InkWell(
                onTap: () {
                  if (onActionClicked != null) onActionClicked!(item);
                  vibrateAsHapticFeedback();
                },
                child: Assets.images.icChipClose.svg(height: 20, width: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
