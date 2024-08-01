import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

class ViewCountWidget extends StatelessWidget {
  const ViewCountWidget({super.key, required this.viewCount});

  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
        color: context.colors.onPrimary.withOpacity(0.7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icEye.svg(),
          SizedBox(width: 4),
          _formattedViewCount().s(12).w(400).c(context.textPrimary)
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
