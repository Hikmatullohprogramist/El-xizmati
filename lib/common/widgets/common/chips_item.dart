import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

import '../../gen/assets/assets.gen.dart';

class ChipsItem extends StatelessWidget {
  const ChipsItem({
    super.key,
    required this.item,
    required this.title,
    required this.onRemoveClicked,
  });

  final dynamic item;
  final String title;
  final Function(dynamic item) onRemoveClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(left: 14, top: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xFF5C6AC4).withOpacity(0.15),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            border: Border.all(
              color: Color(0xFF5C6AC4).withOpacity(0.3),
              width: 1,
            ),
            shape: BoxShape.rectangle,
          ),
          child: Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title
                    .w(500)
                    .s(13)
                    .c(Color(0xFF5C6AC4))
                    .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    onRemoveClicked(item);
                    vibrateAsHapticFeedback();
                  },
                  child: Assets.images.icCloseChip.svg(height: 20, width: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
