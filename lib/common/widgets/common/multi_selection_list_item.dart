import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

import '../../gen/assets/assets.gen.dart';

class MultiSelectionListItem extends StatelessWidget {
  const MultiSelectionListItem({
    super.key,
    required this.item,
    required this.title,
    required this.isSelected,
    required this.onClicked,
  });

  final dynamic item;
  final String title;
  final bool isSelected;
  final Function(dynamic item) onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClicked(item);
          vibrateAsHapticFeedback();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: (title)
                    .toString()
                    .w(500)
                    .s(16)
                    .c(context.colors.textPrimary)
                    .copyWith(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              (isSelected
                      ? Assets.images.icCheckboxSelected
                      : Assets.images.icCheckboxUnselected)
                  .svg(height: 20, width: 20),
            ],
          ),
        ));
  }
}
