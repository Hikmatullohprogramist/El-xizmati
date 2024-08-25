import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/widgets/chips/chip_add_item.dart';
import 'package:El_xizmati/presentation/widgets/chips/chip_count_item.dart';
import 'package:El_xizmati/presentation/widgets/chips/chip_show_less_item.dart';

import 'chip_show_more_item.dart';

class ChipList extends StatelessWidget {
  const ChipList({
    super.key,
    required this.chips,
    required this.isShowAll,
    required this.onClickedAdd,
    required this.onClickedShowLess,
    required this.onClickedShowMore,
    this.minCount = 3,
    this.isShowChildrenCount = true,
    this.autoValidateMode,
    this.validator,
  });

  final List<Widget> chips;
  final Function() onClickedAdd;
  final Function() onClickedShowLess;
  final Function() onClickedShowMore;
  final bool isShowAll;
  final bool isShowChildrenCount;
  final int minCount;
  final AutovalidateMode? autoValidateMode;
  final String? Function(int count)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (value) {
        return validator != null ? validator!(chips.length) : null;
      },
      builder: (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: _getActualChips(),
            ),
            if (state.hasError) SizedBox(height: 8),
            if (state.hasError)
              Row(
                children: [
                  SizedBox(width: 4),
                  (state.errorText!).s(12).c(Colors.red).copyWith(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                ],
              ),
          ],
        );
      },
    );
  }

  List<Widget> _getActualChips() {
    List<Widget> actualChips = [];
    actualChips.add(ChipAddItem(onClicked: onClickedAdd));
    if (chips.length <= minCount) {
      actualChips.addAll(chips);
      return actualChips;
    } else {
      if (isShowAll) {
        actualChips.addAll(chips);
        if (isShowChildrenCount) {
          actualChips.add(ChipShowLessItem(onClicked: onClickedShowLess));
        }
      } else {
        actualChips.addAll(chips.sublist(0, minCount));
        if (isShowChildrenCount) {
          var count = chips.length - minCount;
          actualChips.add(ChipCountItem(count, onClicked: onClickedShowMore));
        } else {
          actualChips.add(ChipShowMoreItem(onClicked: onClickedShowMore));
        }
      }
      return actualChips;
    }
  }
}
