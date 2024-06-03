import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:flutter/services.dart';

class MultiSelectionExpandableItem extends StatelessWidget {
  const MultiSelectionExpandableItem({
    super.key,
    required this.item,
    required this.title,
    required this.isSelected,
    required this.isOpened,
    required this.isParent,
    required this.totalChildCount,
    required this.selectedChildCount,
    required this.onCollapseClicked,
    required this.onCheckboxClicked,
  });

  final dynamic item;
  final String title;
  final bool isSelected;
  final bool isOpened;
  final bool isParent;
  final int totalChildCount;
  final int selectedChildCount;
  final Function(dynamic item) onCollapseClicked;
  final Function(dynamic item) onCheckboxClicked;

  @override
  Widget build(BuildContext context) {
    var isHasSelectedChild = selectedChildCount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onCollapseClicked(item);
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      right: 8,
                      left: 20,
                    ),
                    child: Row(
                      children: [
                        Visibility(
                          visible: isParent,
                          child: (isOpened
                                  ? Assets.images.icArrowDown
                                  : Assets.images.icArrowUp)
                              .svg(),
                        ),
                        Visibility(
                          visible: !isParent,
                          child: SizedBox(width: 32),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: title
                              .toString()
                              .w(isSelected ? 600 : 400)
                              .s(16)
                              .c(context.textPrimary)
                              .copyWith(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  onCheckboxClicked(item);
                  HapticFeedback.lightImpact();
                },
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    right: 20,
                    left: 24,
                  ),
                  child: (isSelected
                          ? Assets.images.icCheckboxSelected
                          : isHasSelectedChild
                              ? Assets.images.icCheckboxHalfSelected
                              : Assets.images.icCheckboxUnselected)
                      .svg(height: 20, width: 20),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
