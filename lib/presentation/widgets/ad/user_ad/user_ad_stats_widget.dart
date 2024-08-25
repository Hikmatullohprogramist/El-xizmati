import 'package:flutter/cupertino.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

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
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1.3, color: Color(0xFFDADDE5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          icon.svg(height: 16, width: 16, color: context.colors.iconSecondary),
          SizedBox(width: 8),
          (count ?? 0)
              .toString()
              .w(600)
              .s(14)
              .c(context.textPrimary),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
