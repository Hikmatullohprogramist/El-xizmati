import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

import '../../gen/assets/assets.gen.dart';

class ChipCountItem extends StatelessWidget {
  const ChipCountItem(
    this.count, {
    super.key,
    this.onClicked,
  });

  final int count;
  final Function()? onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onClicked != null) onClicked!();
      },
      child: Container(
        padding: EdgeInsets.only(left: 14, top: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(width: 1, color: Color(0xFF5C6AC4).withAlpha(64)),
        ),
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Strings.commonMoreWithCount(count: count)
                  .w(600)
                  .s(13)
                  .c(Color(0xFF5C6AC4))
                  .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
              SizedBox(width: 14),
              InkWell(
                onTap: () {
                  if (onClicked != null) onClicked!();
                  vibrateAsHapticFeedback();
                },
                child: Assets.images.icChipExpand.svg(height: 20, width: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
