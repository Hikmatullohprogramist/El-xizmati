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
        SizedBox(height: 20),
        Shimmer.fromColors(
          baseColor: StaticColors.shimmerBaseColor,
          highlightColor: StaticColors.shimmerHighLightColor,
          child: Container(
            width: 120,
            height: 16,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 12),
        Shimmer.fromColors(
          baseColor: StaticColors.shimmerBaseColor,
          highlightColor: StaticColors.shimmerHighLightColor,
          child: Container(
            height: 16,
            margin: EdgeInsets.only(right: 28),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  height: 16,
                  margin: EdgeInsets.only(right: 58),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                width: 45,
                height: 16,
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
                width: 45,
                height: 16,
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
