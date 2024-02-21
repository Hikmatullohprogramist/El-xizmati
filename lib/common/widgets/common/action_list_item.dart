import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

class ActionListItem extends StatelessWidget {
  const ActionListItem({
    super.key,
    required this.item,
    required this.title,
    required this.icon,
    required this.onClicked,
  });

  final dynamic item;
  final String title;
  final SvgPicture icon;
  final Function(dynamic item) onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClicked(item);
        vibrateAsHapticFeedback();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            icon,
            SizedBox(width: 24),
            title.s(16).w(400),
          ],
        ),
      ),
    );
  }
}
