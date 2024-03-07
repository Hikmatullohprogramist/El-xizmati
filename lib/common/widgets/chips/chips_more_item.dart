import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

import '../../gen/assets/assets.gen.dart';

class ChipsMoreItem extends StatelessWidget {
  const ChipsMoreItem({
    super.key,
    required this.count,
    this.onChipClicked,
  });

  final int count;
  final Function()? onChipClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChipClicked != null) onChipClicked!();
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
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Strings.commonMore(count: count)
              Strings.commonMoreWithCount(count: count)
                  .w(600)
                  .s(13)
                  .c(Color(0xFF5C6AC4))
                  .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
              SizedBox(width: 14),
              InkWell(
                onTap: () {
                  if (onChipClicked != null) onChipClicked!();
                  vibrateAsHapticFeedback();
                },
                child: Assets.images.icChipMore.svg(height: 20, width: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
