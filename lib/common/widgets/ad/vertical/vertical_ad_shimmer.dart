import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../colors/static_colors.dart';

class VerticalAdShimmer extends StatelessWidget {
  const VerticalAdShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Shimmer.fromColors(
            baseColor: StaticColors.shimmerBaseColor,
            highlightColor: StaticColors.shimmerHighLightColor,
            child: Container(
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: StaticColors.shimmerBaseColor,
          highlightColor: StaticColors.shimmerHighLightColor,
          child: Container(
            height: 12,
            width: 120,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: StaticColors.shimmerBaseColor,
          highlightColor: StaticColors.shimmerHighLightColor,
          child: Container(
            margin: EdgeInsets.only(right: 28),
            height: 12,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  margin: EdgeInsets.only(right: 58),
                  height: 12,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 12,
                width: 45,
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(width: 6),
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 12,
                width: 45,
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
