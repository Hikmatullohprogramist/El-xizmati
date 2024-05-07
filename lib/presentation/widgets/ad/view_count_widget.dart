import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class ViewCountWidget extends StatelessWidget {
  const ViewCountWidget({super.key, required this.viewCount});

  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
          color: context.colors.onPrimary.withAlpha(200),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icEye.svg(),
          SizedBox(width: 2),
          _formattedViewCount().w(400).s(12).c(context.colors.textPrimary)
        ],
      ),
    );
  }

  String _formattedViewCount() {
    if (viewCount < 1000) return viewCount.toString();
    if (viewCount < 1000000) return '${viewCount ~/ 1000}K';
    return '${viewCount ~/ 1000000}M';
  }
}
