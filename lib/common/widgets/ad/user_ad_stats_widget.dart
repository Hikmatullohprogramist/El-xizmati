import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';

class AdStatsWidget extends StatelessWidget {
  const AdStatsWidget({
    super.key,
    required this.icon,
    required this.count,
  });

  final SvgGenImage icon;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1.3, color: Color(0xFFDADDE5)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        icon.svg(height: 16, width: 16, color: context.colors.iconGrey),
        SizedBox(width: 8),
        ((count ?? 0).toString()).toString().w(600).s(14).c(Color(0xFF41455E))
      ]),
    );
  }
}
