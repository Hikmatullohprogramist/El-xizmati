import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

import '../../gen/assets/assets.gen.dart';

class MultiSelectionListItemForAddress extends StatelessWidget {
  const MultiSelectionListItemForAddress({
    super.key,
    required this.item,
    required this.title,
    required this.isSelected,
    required this.onClicked,
    required this.count,

  });

  final dynamic item;
  final String title;
  final bool isSelected;
  final String count;
  final Function(dynamic item) onClicked;

  @override
  Widget build(BuildContext context) {
    bool checkbox=false;
    return InkWell(
        onTap: () {
          onClicked(item);
          vibrateAsHapticFeedback();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 16,bottom:16,right: 20,left: 20),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          isSelected ?
                          'assets/images/ic_action_arrow_down.svg':
                          'assets/images/ic_action_arrow_to_right.svg',
                          // Replace with your SVG file path
                          width: 10, // Set the width
                          height: 10, // Set the height
                          color: isSelected ? Colors.blueAccent:Colors.black, // Set the color
                        ),
                        SizedBox(width: 15,),
                        (title)
                            .toString()
                            .w(500)
                            .s(16)
                            .c(context.colors.textPrimary)
                            .copyWith(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),


                      ],
                    ),
                  ),
                  (isSelected
                      ? Assets.images.icCheckboxSelected
                      : Assets.images.icCheckboxUnselected)
                      .svg(height: 20, width: 20),
                ],
              ),
            ),
          ],
        ));
  }
}
